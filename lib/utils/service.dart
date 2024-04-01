import 'dart:convert';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ServiceWithHeader {
  final String loginURL;

  ServiceWithHeader(
    this.loginURL,
  );

  Future data() async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    final response = await http.get(Uri.parse(loginURL), headers: {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    });

    print(response.body);
    var status = jsonDecode(response.body);
    print('heee' + status['status'].toString());
    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else {
      String data = response.body;
      return jsonDecode(data);
    }
  }

  Future datawithoutheader() async {
    final response = await http.get(Uri.parse(loginURL));
    var status = jsonDecode(response.body);
    print('heee' + status['status'].toString());
    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return {
        "error": status['Message'],
      };
    }
  }
}

class ServiceWithHeaderWithbody {
  final String loginURL;
  final Map<String, dynamic> body;

  ServiceWithHeaderWithbody(
    this.loginURL,
    this.body,
  );

  Future postdatawithoutbody() async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    final response = await http.post(Uri.parse(loginURL), body: body, headers: {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    });
   
    var restatus = jsonDecode(response.body);
   
    if (restatus['status'].toString().toUpperCase() == 'SUCCESS' ||
        restatus['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else {
      String data = response.body;
      return jsonDecode(data);
    }
  }
}
