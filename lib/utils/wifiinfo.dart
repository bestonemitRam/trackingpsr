import 'package:network_info_plus/network_info_plus.dart';

class WifiInfo {
  final info = NetworkInfo();

  Future<String?> wifiname() async {
    return info.getWifiName();
  }

  Future<String?> wifiBSSID() async {
    return info.getWifiBSSID();
  }

  Future<String?> wifiIP() async {
    return info.getWifiIP();
  }

  Future<String?> wifiIPv6() async {
    return info.getWifiIPv6();
  }

  Future<String?> wifiSubmask() async {
    return info.getWifiSubmask();
  }

  Future<String?> wifiBroadcast() async {
    return info.getWifiSubmask();
  }

  Future<String?> wifiGateway() async {
    return info.getWifiGatewayIP();
  }
}
