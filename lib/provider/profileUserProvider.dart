import 'dart:convert';
import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/dashboard/User.dart';
import 'package:bmitserp/data/source/network/model/login/Login.dart';
import 'package:bmitserp/data/source/network/model/profile/Profileresponse.dart';
import 'package:bmitserp/model/ProfileUserModel.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bmitserp/model/profile.dart' as up;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserProvider with ChangeNotifier {
  ProfileUserModel profileuserModel = ProfileUserModel();

  List<ProfileDatas> _profileuserlist = [];
  List<ProfileDatas> get profileuserList => _profileuserlist;

  bool datanotfound = false;

  Future profileuserlist() async {
    datanotfound = false;

    var url = APIURL.PROFILE_URL;

    ServiceWithHeader service = ServiceWithHeader(url);
    final response = await service.data();

    _profileuserlist = [];
    profileuserModel = ProfileUserModel.fromJson(response);

    if (profileuserModel.data != null) {
      if (profileuserModel.data!.profileData != null) {
     
        var profileuser = profileuserModel.data!.profileData;
        _profileuserlist.add(profileuser!);
        parseUser(profileuserModel.data!.profileData!);
        Apphelper.USER_DOB = profileuserModel.data!.profileData!.dob!;
        Apphelper.USER_GENDAR = profileuserModel.data!.profileData!.gender!;
        Apphelper.USER_CONTACT = profileuserModel.data!.profileData!.contact!;
        Apphelper.USER_AVATAR = profileuserModel.data!.profileData!.avatar!;
        Apphelper.USER_NAME = profileuserModel.data!.profileData!.fullName!;
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(
            Apphelper.USER_AVATAR, profileuserModel.data!.profileData!.avatar!);
        await prefs.setString(
            Apphelper.USER_EMAIL, profileuserModel.data!.profileData!.mail!);
        await prefs.setString(
            Apphelper.USER_NAME, profileuserModel.data!.profileData!.fullName!);
        await prefs.setString(
            Apphelper.USER_GENDAR, profileuserModel.data!.profileData!.gender!);
        await prefs.setString(Apphelper.USER_CONTACT,
            profileuserModel.data!.profileData!.contact!);
        await prefs.setString(
            Apphelper.USER_DOB, profileuserModel.data!.profileData!.dob!);
        Apphelper.USER_DOB = profileuserModel.data!.profileData!.dob!;
        Apphelper.USER_GENDAR = profileuserModel.data!.profileData!.gender!;
        Apphelper.USER_CONTACT = profileuserModel.data!.profileData!.contact!;
        Apphelper.USER_AVATAR = profileuserModel.data!.profileData!.avatar!;
        Apphelper.USER_NAME = profileuserModel.data!.profileData!.fullName!;
      }
    }
    datanotfound = true;
    notifyListeners();
  }

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

  void parseUser(ProfileDatas profile) {
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
}