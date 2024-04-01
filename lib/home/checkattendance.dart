
import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/main.dart';
import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/utils/authservice.dart';
import 'package:bmitserp/widget/attendance_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:flutter/cupertino.dart';

class CheckInCheckOut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CheckAttendanceState();
}

class CheckAttendanceState extends State<CheckInCheckOut> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<PrefProvider>(context);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE , MMMM d , yyyy').format(now);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            formattedDate,
            style: TextStyle(color: Colors.white),
          )),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(90)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: HexColor("#3b98cc").withOpacity(.5),
                  //  attendanceList['check-in'] != "-" &&
                  //         attendanceList['check-out'] == "-"
                  //     ? HexColor("#e82e5f").withOpacity(.5)
                  //     : HexColor("#3b98cc").withOpacity(.5),
                  child: IconButton(
                      iconSize: 70,
                      onPressed: () async 
                      {
                        //  bool status = await _determinePosition();
                        LocationPermission permission =
                            await Geolocator.checkPermission();

                        if (permission == LocationPermission.denied)
                         {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                    title: Text(
                                        " Prominent Disclosure Regarding Background Location Access"),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          'Background Location Usage:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Our app will only access your device\'s location in the background when you initiate a check-in or check-out time only. When the  Employee check-out from the application, then location access of the device will be stop.',
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Limited to access location at Check-In and Check-Out time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'This background location access is solely for the purpose of providing accurate check-in and check-out data and ensuring the efficiency of our service',
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Purposeful Access',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Our app manage and adjust location permissions within the settings of our app, providing you with full control over when and how your location information is accessed.',
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Your Privacy Matters:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'We are committed to ensuring that your location data is used responsibly and transparently. We do not track your location continuously in the background, and your privacy is of utmost importance to us',
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop(false);

                                          final data = await dbHelper
                                              .fetchLocationData();
                                          print('Location Data: $data');

                                          if (await pref.getUserAuth()) {
                                            bool isAuthenticated =
                                                await AuthService
                                                    .authenticateUser();
                                            if (isAuthenticated) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  useRootNavigator: true,
                                                  builder: (context) {
                                                    return AttedanceBottomSheet();
                                                  });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Either no biometric is enrolled or biometric did not match'),
                                              )));
                                            }
                                          } else {
                                            showModalBottomSheet(
                                                context: context,
                                                useRootNavigator: true,
                                                builder: (context) {
                                                  return AttedanceBottomSheet();
                                                });
                                          }
                                        },
                                        child: Text('Deny'),
                                      ),
                                      CupertinoDialogAction(
                                        child: Text("Accept"),
                                        onPressed: () async {
                                          permission = await Geolocator
                                              .requestPermission();

                                          if (permission !=
                                              LocationPermission.denied) {
                                            Navigator.pop(context);
                                            final data = await dbHelper
                                                .fetchLocationData();
                                            print('Location Data: $data');

                                            if (await pref.getUserAuth()) {
                                              bool isAuthenticated =
                                                  await AuthService
                                                      .authenticateUser();
                                              if (isAuthenticated) {
                                                showModalBottomSheet(
                                                    context: context,
                                                    useRootNavigator: true,
                                                    builder: (context) {
                                                      return AttedanceBottomSheet();
                                                    });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                            content: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                      'Either no biometric is enrolled or biometric did not match'),
                                                )));
                                              }
                                            } else {
                                              showModalBottomSheet(
                                                  context: context,
                                                  useRootNavigator: true,
                                                  builder: (context) {
                                                    return AttedanceBottomSheet();
                                                  });
                                            }
                                          }
                                        },
                                      )
                                    ],
                                  ));
                       
                       
                        } else {
                          final data = await dbHelper.fetchLocationData();
                          print('Location Data: $data');

                          if (await pref.getUserAuth()) {
                            bool isAuthenticated =
                                await AuthService.authenticateUser();
                            if (isAuthenticated) {
                              showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  builder: (context) {
                                    return AttedanceBottomSheet();
                                  });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    'Either no biometric is enrolled or biometric did not match'),
                              )));
                            }
                          } else {
                            showModalBottomSheet(
                                context: context,
                                useRootNavigator: true,
                                builder: (context) {
                                  return AttedanceBottomSheet();
                                });
                          }
                        }
                      },
                      icon: Icon(
                        Icons.fingerprint_sharp,
                        color: Apphelper.CHECK_STATUS == "0"
                            ? Colors.white
                            : Colors.brown,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            "Check In | Check Out",
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
          SizedBox(
            height: 15,
          ),
          // Container(
          //   width: double.infinity,
          //   child: LinearPercentIndicator(
          //     animation: true,
          //     animationDuration: 1000,
          //     lineHeight: 30.0,
          //     padding: EdgeInsets.all(0),
          //     percent: attendanceList['production-time']!,
          //     center: Text(
          //       attendanceList['production_hour'],
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     barRadius: const Radius.circular(20),
          //     backgroundColor: HexColor("#3dFFFFFF"),
          //     progressColor: attendanceList['check-in'] != "-" &&
          //             attendanceList['check-out'] == "-"
          //         ? HexColor("#e82e5f")
          //         : HexColor("#3b98cc"),
          //   ),
          // ),

          // Container(
          //   padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           attendanceList['check-in']!,
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         Text(
          //           attendanceList['check-out']!,
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ]),
          // ),
        ],
      ),
    );
  }

  Future<bool> _determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(
                    " Prominent Disclosure Regarding Background Location Access"),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Background Location Usage:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Our app will only access your device\'s location in the background when you initiate a check-in or check-out time only. When the  Employee check-out from the app then location access of the device is stop.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Limited to Check-In and Check-Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This background location access is solely for the purpose of providing accurate check-in and check-out data and ensuring the efficiency of our service',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Purposeful Access',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Our app manage and adjust location permissions within the settings of our app, providing you with full control over when and how your location information is accessed.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your Privacy Matters:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'We are committed to ensuring that your location data is used responsibly and transparently. We do not track your location continuously in the background, and your privacy is of utmost importance to us',
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Deny'),
                  ),
                  CupertinoDialogAction(
                    child: Text("Accept"),
                    onPressed: () async {
                      Navigator.pop(context);
                      permission = await Geolocator.requestPermission();
                    },
                  )
                ],
              ));
    }
    return true;
  }

  // Future<bool> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     throw 'Location services are disabled';
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw 'Location permissions are denied';
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     throw 'Location permissions are permanently denied';
  //   }
  // }
}
