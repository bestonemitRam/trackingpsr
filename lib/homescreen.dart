import 'dart:async';


import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/home/checkattendance.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/screen/distributors/distributor_screen.dart';
import 'package:bmitserp/screen/shop_module/shop_listing_screen.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:bmitserp/widget/homescreen/cardoverview.dart';
import 'package:bmitserp/widget/homescreen/checkattendance.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var init = true;
  var isVisible = false;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();

      init = false;
    }

    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final leaveData = await leaveProvider.getStateList();

    EasyLoading.dismiss(animation: true);
    if (!mounted) {
      return "Loaded";
    }

    if (leaveData == 200) {}

    return "Loaded";
  }

  @override
  void initState() {
    bool isFirebaseInitialized = Firebase.apps.isNotEmpty;
    setupRemoteConfig();
    // _getCurrentLocation();
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context, listen: true);
    final homeData = leaveData.getHomeData;
    return Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            edgeOffset: 50,
            onRefresh: () async {
              await initialState();
            },
            child: SafeArea(
                child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    HeaderProfile(),
                    SizedBox(
                      height: 30,
                    ),
                    CheckAttendance(),
                    SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(ShopListingScreen());
                          },
                          child: CardOverView(
                              type: 'Retailer',
                              value: homeData.isNotEmpty
                                  ? homeData[0].totalRetailers.toString()
                                  : "",
                              icon: Icons.work),
                        ),
                        InkWell(
                          onTap: () 
                          {
                            Get.to(DistributorScreen());
                          },
                          child: CardOverView(
                              type: 'Distributor',
                              value: homeData.isNotEmpty
                                  ? homeData[0].totalDistributors.toString()
                                  : "",
                              icon: Icons.shop),
                        )
                      ],
                    ),
                    CheckInCheckOut()
                  ],
                ),
              ),
            )),
          ),
        ));
  }

  setupRemoteConfig() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    final remoteConfig = FirebaseRemoteConfig.instance;

    remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration.zero));
    await remoteConfig.fetch();
    await remoteConfig.activate();
    if (remoteConfig.getValue(APIURL.appUpdate).asBool()) {
      if (version != remoteConfig.getValue(APIURL.Version).asString() &&
          remoteConfig.getValue(APIURL.forceFully).asBool()) {
        _forceFullyupdate(remoteConfig.getString(APIURL.updateUrl),
            remoteConfig.getString(APIURL.updateMessage));
        return;
      }
      if (version != remoteConfig.getValue(APIURL.Version).asString()) {
        _update(remoteConfig.getString(APIURL.updateUrl),
            remoteConfig.getString(APIURL.updateMessage));
        return;
      }
    }
  }

  void _update(String url, String Message) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Update ! '),
            content: Text(Message),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                },
                child: const Text('May be later'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  _lunchInBrowser(url);
                },
                child: const Text('Update'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  void _forceFullyupdate(
    String url,
    String Message,
  ) {
    showCupertinoDialog(
        context: context!,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: CupertinoAlertDialog(
              insetAnimationCurve: Curves.easeInOutCubic,
              insetAnimationDuration: Duration(milliseconds: 600),
              title: const Text(
                'Update required !',
              ),
              content: Text(Message),
              actions: [
                // The "Yes" button

                // The "No" button
                CupertinoDialogAction(
                  onPressed: () {
                    _lunchInBrowser(url);
                  },
                  child: const Text('Update'),
                  isDefaultAction: false,
                  isDestructiveAction: false,
                )
              ],
            ),
          );
        });
  }

  Future<void> _lunchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{"headesr_key": "headers_value"});
    } else {
      throw "url not lunched $url";
    }
  }

}

class PermissionPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Permission Required'),
      content: Text(
          'This app needs access to your location even when the app is in the background in order to provide better services.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Deny'),
        ),
        TextButton(
          onPressed: () async {
            // Request permission
            var status = await Permission.location.request();
            if (status.isGranted) {
              // Permission granted
              // Do something with permission
            } else if (status.isDenied) {
              // Permission denied
              // Show error message or handle accordingly
              openAppSettings();
            } else if (status.isPermanentlyDenied) {
              // Permission permanently denied, open app settings
              openAppSettings();
            }
            Navigator.of(context).pop(true);
          },
          child: Text('Allow'),
        ),
      ],
    );
  }
}
