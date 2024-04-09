import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/profile/Profile.dart';
import 'package:bmitserp/data/source/network/model/profile/Profileresponse.dart';
import 'package:bmitserp/model/profile.dart' as up;
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  final up.Profile _profile = up.Profile(
      id: 0,
      avatar: '',
      name: '',
      username: '',
      email: '',
      post: '',
      phone: '',
      dob: '',
      gender: '',
      address: '',
      bankName: '',
      bankNumber: '',
      joinedDate: '');

  up.Profile get profile {
    return _profile;
  }

  Future<Profileresponse> getProfile() async {
    var uri = Uri.parse(APIURL.PROFILE_URL);
    Preferences preferences = Preferences();
    checkValueInPref(preferences);
    EasyLoading.show(status: "Changing", maskType: EasyLoadingMaskType.black);

    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      EasyLoading.dismiss(animation: true);
      if (response.statusCode == 200) {
       

        final responseJson = Profileresponse.fromJson(responseData);
        parseUser(responseJson.data!.profileData!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  void parseUser(ProfileData profile) {
    _profile.id = profile.userId!;
    _profile.avatar = profile.avatar!;
    _profile.name = profile.fullName!;
    _profile.username = profile.fullName!;
    _profile.email = profile.mail!;
    _profile.post = '';
    _profile.phone = profile.contact!;
    _profile.dob = profile.dob!;
    _profile.gender = profile.gender!;
    _profile.address = "";
    _profile.bankName = "";
    _profile.bankNumber = "";
    _profile.joinedDate = "";
    notifyListeners();
  }

  void checkValueInPref(Preferences preferences) async {
    final user = await preferences.getUser();
    _profile.name = user.fullName;
    _profile.username = user.fullName;
    _profile.email = user.mail;
    _profile.avatar = user.avatar;
    notifyListeners();
  }

  Future<Profileresponse> updateProfile(
      String name,
      String email,
      String address,
      String dob,
      String gender,
      String phone,
      File avatar) async {
    var uri = Uri.parse(Constant.EDIT_PROFILE_URL);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    dynamic response;
    try {
      if (avatar.path != '') {
        var requests = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        final img.Image capturedImage =
            img.decodeImage(await File(avatar.path).readAsBytes())!;
        final img.Image orientedImage = img.bakeOrientation(capturedImage);
        var file =
            await File(avatar.path).writeAsBytes(img.encodeJpg(orientedImage));

        requests.files.add(
          http.MultipartFile(
            'avatar',
            file.readAsBytes().asStream(),
            await avatar.length(),
            filename: Random().hashCode.toString(),
          ),
        );
        requests.fields['full_name'] = name;
        requests.fields['mail'] = email;
        requests.fields['contact'] = phone;
        requests.fields['dob'] = dob;
        requests.fields['gender'] = gender;
        requests.headers.addAll(headers);

        response = await requests.send();

        await response.stream.transform(utf8.decoder).listen((value) {
          final responseJson = Profileresponse.fromJson(jsonDecode(value));
          if (responseJson.statusCode == 200) {
            //parseUser(responseJson.data);
            return responseJson;
          } else {
            var errorMessage = responseJson.message;
            //throw errorMessage;
          }
        });

        // final request = http.MultipartRequest('POST', uri);
        // Map<String, String> headers =
        // {
        //   'Accept': 'application/json; charset=UTF-8',
        //   'Content-type': 'multipart/form-data',
        //   'Authorization': 'Bearer $token'
        // };

        // request.headers.addAll(headers);

        // final file = await http.MultipartFile.fromPath('avatar', avatar.path);

        // request.files.add(file);
        // request.fields['full_name'] = name;
        // request.fields['mail'] = email;
        // request.fields['contact'] = phone;
        // request.fields['dob'] = dob;
        // request.fields['gender'] = gender;

        // try {
        //   final streamedResponse = await request.send();
        //   final response = await http.Response.fromStream(streamedResponse);
        //   final responseJson = Profileresponse.fromJson(jsonDecode(response.body));
      
        //   var out = jsonDecode(response.body);
        //   if (out['status'] == "success")
        //   {
        //     // DialogHelper.showFlutterToast(strMsg: out['message']);
        //     // Navigator.pop(context);
        //   }
        // } catch (e) {
     
        // }

        return Future.error('error');
      } else {
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        response = await http.post(uri, headers: headers, body: {
          'full_name': name,
          'mail': email,
          'contact': phone,
          'dob': dob,
          'gender': gender,
        });

        final responseData = json.decode(response.body);
        if (response.statusCode == 200) {
         
          final responseJson = Profileresponse.fromJson(responseData);

          //  parseUser(responseJson.data);
          return responseJson;
        } else {
          var errorMessage = responseData['message'];
          throw errorMessage;
        }
      }
    } catch (error) {
      throw error;
    }
  }

  Future updateProfiles(String name, String email, String address, String dob,
      String gender, String phone, File avatar) async {
    var uri = Uri.parse(APIURL.UPDATE_PROFILE);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

   

    dynamic response;
    try {
      if (avatar.path != '') {
        var request = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        request.headers.addAll(headers);

        final file = await http.MultipartFile.fromPath('avatar', avatar.path);

        request.files.add(file);
        request.fields['full_name'] = name;
        request.fields['mail'] = email;
        request.fields['contact'] = phone;
        request.fields['dob'] = dob;
        request.fields['gender'] = gender;

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);
        

          var out = jsonDecode(response.body);
          final responseData = json.decode(response.body);

          if (response.statusCode == 201) {
            final responseJson = Profileresponse.fromJson(responseData);
            parseUser(responseJson.data!.profileData!);
            Fluttertoast.showToast(
                msg: "Profile Updated Successfully !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            EasyLoading.dismiss(animation: true);

            Get.back();
          } else {
            EasyLoading.dismiss(animation: true);
            Fluttertoast.showToast(
                msg: "Error !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        } catch (e) {
         
        }

        return Future.error('error');
      } else {
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        response = await http.post(uri, headers: headers, body: {
          'full_name': name,
          'mail': email,
          'contact': phone,
          'dob': dob,
          'gender': gender,
        });

        final responseData = json.decode(response.body);
        var out = jsonDecode(response.body);

       
        if (response.statusCode == 201) {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "Profile Updated Successfully !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);

          Get.back();
          //  final responseJson = Profileresponse.fromJson(responseData);

          // parseUser(responseJson.data);
          // return responseJson;
        } else {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "Error !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
