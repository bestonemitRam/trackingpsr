import 'dart:convert';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/model/advance_order_and_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

class InventoryProvider with ChangeNotifier {
  final List<NormalInventory> _normalOrderlist = [];

  List<NormalInventory> get normalOrderlist {
    return [..._normalOrderlist];
  }

  Future<AdvanceAndNormalOrder> getInventoryList() async {
    var uri = Uri.parse(APIURL.GET_INVENTORY_LIST);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response >> ');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      try {
        EasyLoading.show(
            status: "Loading", maskType: EasyLoadingMaskType.black);
        final response = await http.get(uri, headers: headers);
        final responseData = json.decode(response.body);

        final responseJson = AdvanceAndNormalOrder.fromJson(responseData);
        print("Check leave ddfdfgata  ${response.statusCode}");

        if (response.statusCode == 200) {
          makeNormalOrder(responseJson.result!);
          EasyLoading.dismiss(animation: true);

          return responseJson;
        } else {
          EasyLoading.dismiss(animation: true);
          var errorMessage = responseData['message'];
          return responseJson;
        }
      } catch (error) {
        EasyLoading.dismiss(animation: true);
        throw error;
      }
    } else {
      EasyLoading.dismiss(animation: true);
      Fluttertoast.showToast(
          msg: "Please check your internet connections!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      var errorMessage = "Please check your internet connection! ";
      throw errorMessage;
    }
  }

  void makeNormalOrder(AdvanceOrderData data) {
    _normalOrderlist.clear();

    print("jkfghjkkjfgj ${data.normalInventory!.length}");

    for (var normalOrder in data.normalInventory!.reversed) {
      _normalOrderlist.add(normalOrder!);
    }

    notifyListeners();
  }
}
