import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/login/Loginresponse.dart';
import 'package:flutter/material.dart';
import 'package:bmitserp/data/source/network/model/login/Login.dart';
import 'package:bmitserp/data/source/network/model/login/User.dart';

class PrefProvider with ChangeNotifier {
  var _userName = '';
  var _fullname = '';
  var _avatar = '';
  var _auth = false;

  String get userName {
    return _userName;
  }

  String get fullname {
    return _fullname;
  }

  String get avatar {
    return _avatar;
  }

  bool get auth {
    return _auth;
  }

  void getUser() async {
   
    Preferences preferences = Preferences();
    _userName = await preferences.getUsername();
    _fullname = await preferences.getFullName();
    _avatar = await preferences.getAvatar();

    await preferences.getEmail();
    notifyListeners();
  }

  Future<bool> getUserAuth() async {
    Preferences preferences = Preferences();
    return await preferences.getUserAuth();
  }

  void saveUser(Result data) async {
    Preferences preferences = Preferences();
    preferences.saveUser(data);
    notifyListeners();
  }

  void saveBasicUser(User user) async {
    Preferences preferences = Preferences();
    preferences.saveBasicUser(user);
    notifyListeners();
  }

  void saveAuth(bool value) async {
    Preferences preferences = Preferences();
    preferences.saveUserAuth(value);
    _auth = await preferences.getUserAuth();
    notifyListeners();
  }
}
