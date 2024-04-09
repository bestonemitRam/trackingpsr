import 'dart:convert';
import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/connect.dart';
import 'package:bmitserp/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:bmitserp/data/source/network/model/tadadetail/tadadetailresponse.dart';
import 'package:bmitserp/data/source/network/model/tadalist/tadalistresponse.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TadaRepository {
  Future<TadaListResponse> getTadaListdata() async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
  

    try {
      final response =
          await Connect().getResponse(APIURL.TADA_LIST_URL, headers);
     

      String data = response.body;
      final responseData = jsonDecode(data);
      

      if (response.statusCode == 200) {
        final tadaResponse = TadaListResponse.fromJson(jsonDecode(data));

      

        return tadaResponse;
      } else {
        var errorMessage = responseData['message'];
       
        throw errorMessage;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<TadaDetailResponse> getTadaDetail(String tadaId) async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await Connect()
          .getResponse(Constant.TADA_DETAIL_URL + "/${tadaId}", headers);
     

     

      String data = response.body;
      final responseData = jsonDecode(data);
      if (response.statusCode == 200) {
        final tadaResponse = TadaDetailResponse.fromJson(responseData);

        return tadaResponse;
      } else {
        var errorMessage = responseData['message'];
     
        throw errorMessage;
      }
    } catch (e) {
    
      throw e;
    }
  }

  Future<TadaListResponse> createTada(String title, String description,
      String expenses, List<PlatformFile> fileList) async {
    var uri = Uri.parse(APIURL.TADA_STORE_URL);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };



    var requests = http.MultipartRequest('POST', uri);
    requests.headers.addAll(headers);

    requests.fields.addAll({
      "title": title,
      "description": description,
      "total_expense": expenses,
    });

   

    for (var filed in fileList) {
      final file = File(filed.path!);
      final stream = http.ByteStream(Stream.castFrom(file.openRead()));
      final length = await file.length();

      final multipartFile = http.MultipartFile('attachments[]', stream, length,
          filename: filed.name);
      requests.files.add(multipartFile);
    }
    final responseStream = await requests.send();

    final response = await http.Response.fromStream(
      responseStream,
    );
   
    final responseData = json.decode(response.body);
    String data = response.body;
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      // EasyLoading.dismiss(animation: true);
      // showToast("Tada has been submitted");
      // Get.back();
      final tadaResponse = TadaListResponse.fromJson(jsonDecode(data));
      return tadaResponse;
    } else {
      var errorMessage = responseData['message'];
   
      throw errorMessage;
    }
  }
}
