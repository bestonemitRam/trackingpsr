import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:flutter/services.dart';

class LocationService {
  static const MethodChannel _channel = MethodChannel('location_channel');
  Preferences preferences = Preferences();

  static Future<void> startBackgroundLocation(String token, int userID) async {
    try {
    

      await _channel.invokeMethod('startBackgroundLocation',
          {"token": token, "userID": userID.toString()});
    } on PlatformException catch (e) {
    
    }
  }

  static Future<void> stopService() async {
    try {
      await _channel.invokeMethod('stopService');
    } on PlatformException catch (e) {
    
    }
  }
}
