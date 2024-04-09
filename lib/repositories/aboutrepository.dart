import 'dart:convert';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/connect.dart';
import 'package:bmitserp/data/source/network/model/about/Aboutresponse.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AboutRepository {
  Future<Aboutresponse> getContent(String value) async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await Connect()
          .getResponse("${Constant.CONTENT_URL}/$value/", headers);
      
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final dashboardResponse = Aboutresponse.fromJson(responseData);
        return dashboardResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }
}
