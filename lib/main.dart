import 'package:bmitserp/provider/inventoryprovider.dart';
import 'package:bmitserp/provider/productprovider.dart';
import 'package:device_info_plus/device_info_plus.dart';
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


import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

const fetchBackground = "fetchBackground";
const getLocation = "getLocation";
const checkLocationEnabled = "checkLocationEnabled";
final dbHelper = DatabaseHelper();

// @pragma('vm:entry-point')
// void callbackDispatcher(BuildContext ctx) {
//   Workmanager().executeTask((task, inputData) async
//    {
//     print("Native called background task: $task");
//     switch (task) {
//       case getLocation:
//         // bgLocationTask();
//         break;
//       case checkLocationEnabled:
//         hasUserClosedLocation(ctx);
//         break;
//       case fetchBackground:
//         print("Getting user locaton");
//         // Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//         //onStart();
//         break;
//     }
//     return Future.value(true);
//   });
// }

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  await initializeService();
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
   
  } else {
   
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

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();

//   /// OPTIONAL, using custom notification channel id
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'my_foreground', // id
//     'MY FOREGROUND SERVICE', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.low, // importance must be at low or higher level
//   );

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   if (Platform.isIOS || Platform.isAndroid) {
//     await flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//         iOS: DarwinInitializationSettings(),
//         android: AndroidInitializationSettings('ic_bg_service_small'),
//       ),
//     );
//   }

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       // auto start service
//       autoStart: false,
//       isForegroundMode: false,

//       notificationChannelId: 'my_foreground',
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: 888,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,

//       // this will be executed when app is in foreground in separated isolate
//       onForeground: onStart,

//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
// }

// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();

//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.reload();
//   final log = preferences.getStringList('log') ?? <String>[];
//   log.add(DateTime.now().toIso8601String());
//   await preferences.setStringList('log', log);

//   return true;
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();
//   final backgroundApiViewModel = DashboardProvider();

//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually

//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.setString("hello", "world");

//   /// OPTIONAL when use custom notification
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) 
//     {
//       service.setAsBackgroundService();
  
//     });
//   }

//   service.on('stopService').listen((event) 
//   {
//     service.stopSelf();
//   });

//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
       
//         flutterLocalNotificationsPlugin.show(
//           888,
//           'COOL SERVICE',
//           'Awesome ${DateTime.now()}',
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'my_foreground',
//               'MY FOREGROUND SERVICE',
//               icon: 'ic_bg_service_small',
//               ongoing: true,
//             ),
//           ),
//         );

//         // if you don't using custom notification, uncomment this
//         service.setForegroundNotificationInfo(
//           title: "My App Service",
//           content: "Updated at ${DateTime.now()}",
//         );
//       }
//     }

//     backgroundApiViewModel.getCurrentPosition();

//     /// you can see this log in logcat
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }

//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }

//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });
// }

Future<void> _messageHandler(RemoteMessage message) async {
 
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

// void initBackgroundLocation() {
//   BackgroundLocation.startLocationService();
//   BackgroundLocation.getLocationUpdates((location) {});
// }

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

// void stopLocationService() {
//   BackgroundLocation.stopLocationService();
// }

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
