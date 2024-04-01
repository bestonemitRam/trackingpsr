import 'package:bmitserp/provider/inventoryprovider.dart';
import 'package:bmitserp/provider/productprovider.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/utils/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/model/auth.dart';
import 'package:bmitserp/provider/attendancereportprovider.dart';
import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/morescreenprovider.dart';
import 'package:bmitserp/provider/payslipprovider.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/provider/profileprovider.dart';
import 'package:bmitserp/screen/auth/login_screen.dart';
import 'package:bmitserp/screen/dashboard/dashboard_screen.dart';
import 'package:bmitserp/screen/profile/editprofilescreen.dart';
import 'package:bmitserp/screen/splashscreen.dart';
import 'package:bmitserp/utils/navigationservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/source/network/model/logout/Logoutresponse.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:background_location/background_location.dart';

const fetchBackground = "fetchBackground";
const getLocation = "getLocation";
const checkLocationEnabled = "checkLocationEnabled";
final dbHelper = DatabaseHelper();

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPref = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }

  AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'digital_hr_group',
            channelKey: 'digital_hr_channel',
            channelName: 'Digital Hr notifications',
            channelDescription: 'Digital HR Alert',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'digital_hr_group', channelGroupName: 'HR group')
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((event) {
    FlutterRingtonePlayer.play(
      fromAsset: "assets/sound/beep.mp3",
    );
    try {
      InAppNotification.show(
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            leading: Container(
                height: double.infinity, child: Icon(Icons.notifications)),
            iconColor: HexColor("#011754"),
            textColor: HexColor("#011754"),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Text(
              event.notification!.title!,
            ),
            subtitle: Text(
              event.notification!.body!,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      print(e);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(MyApp());
  configLoading();
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  FlutterRingtonePlayer.play(
    fromAsset: "assets/sound/beep.mp3",
  );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false
    ..dismissOnTap = false;
}

void initBackgroundLocation() {
  BackgroundLocation.startLocationService();
  BackgroundLocation.getLocationUpdates((location) {});
}

Future<void> hasUserClosedLocation(BuildContext context) async {
  Timer.periodic(Duration(seconds: 5), (timer) async {
    bool _serviceEnabled;
    LocationPermission _permission;
    Position _position;
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      var uri = Uri.parse(Constant.LOGOUT_URL);

      Preferences preferences = Preferences();
      String token = await preferences.getToken();
      int getUserID = await preferences.getUserId();

      Map<String, String> headers = {
        'Accept': 'application/json; charset=UTF-8',
        'user_token': '$token',
        'user_id': '$getUserID',
      };

      try {
        final response = await http.get(uri, headers: headers);
        debugPrint(response.body.toString());

        final responseData = json.decode(response.body);

        if (response.statusCode == 200 || response.statusCode == 401) {
          final jsonResponse = Logoutresponse.fromJson(responseData);

          preferences.clearPrefs();
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          var errorMessage = responseData['message'];
          throw errorMessage;
        }
      } catch (e) {
        throw e;
      }
      return;
    } else {
      try {
        _position = await Geolocator.getCurrentPosition();
      } catch (e) {}
    }
  });
}

void stopLocationService() {
  BackgroundLocation.stopLocationService();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String userName = '';
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return StreamProvider<InternetConnectionStatus>(
          initialData: InternetConnectionStatus.connected,
          create: (_) {
            return InternetConnectionChecker().onStatusChange;
          },
          child: OverlaySupport.global(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (ctx) => Auth(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => Preferences(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => LeaveProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => PrefProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => ProfileProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => AttendanceReportProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => DashboardProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => MoreScreenProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => PaySlipProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => ProductProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => InventoryProvider(),
                ),
              ],
              child: Portal(
                child: InAppNotification(
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onVerticalDragDown: (details) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: GetMaterialApp(
                      navigatorKey: NavigationService.navigatorKey,
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        canvasColor: const Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'GoogleSans',
                        primarySwatch: Colors.blue,
                      ),
                      initialRoute: '/',
                      routes: {
                        '/': (_) => SplashScreen(),
                        LoginScreen.routeName: (_) => LoginScreen(),
                        DashboardScreen.routeName: (_) => DashboardScreen(),
                        EditProfileScreen.routeName: (_) => EditProfileScreen(),
                      
                      },
                      builder: EasyLoading.init(),
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
