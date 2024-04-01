import 'dart:convert';


import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/retailer/reatailer_model.dart';
import 'package:bmitserp/model/distributor_data_list.dart';
import 'package:bmitserp/model/distributor_model.dart';
import 'package:bmitserp/model/distributor_state_model.dart';

import 'package:bmitserp/model/shop.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'package:internet_connection_checker/internet_connection_checker.dart';

class LeaveProvider with ChangeNotifier {
  final List<Shop> _shoplist = [];

  List<Shop> get shoplist {
    return [..._shoplist];
  }

  Future<RetailerModel> getShopList() async {
   
    var uri = Uri.parse(APIURL.GET_RETAILER_LIST);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      try {
        EasyLoading.show( status: "Loading", maskType: EasyLoadingMaskType.black);
        final response = await http.get(uri, headers: headers);
        final responseData = json.decode(response.body);

     
        final responseJson = RetailerModel.fromJson(responseData);
        if (response.statusCode == 200) {
          debugPrint(responseData.toString());

          makeShopList(responseJson.result!);
          EasyLoading.dismiss(animation: true);

          return responseJson;
        } else {
          EasyLoading.dismiss(animation: true);
          var errorMessage = responseData['message'];
          return responseJson;
        }
      } catch (error)
       {
        EasyLoading.dismiss(animation: true);
        throw error;
      }
    } else {
      EasyLoading.dismiss(animation: true);
      var errorMessage = "Please check your internet connection! ";
      throw errorMessage;
    }
  }

  void makeShopList(ResultData data)
   {
    _shoplist.clear();

    print("dfgjkfgh    ${data.retailersList}");

    for (var shop in data.retailersList!.reversed) {
      _shoplist.add(Shop(
          id: int.parse(shop.id.toString() ?? '0'),
          retailerName: shop.retailerName ?? " ",
          retailerShopName: shop.retailerShopName ?? "",
          retailerAddress: shop.retailerAddress ?? "",
          retailerLatitude: shop.retailerLatitude ?? " ",
          retailerLongitude: shop.retailerLongitude ?? " ",
          retailerShopImage: shop.retailerShopImage ?? " ",
          retailer_mobile_number:shop.retailer_mobile_number??"" ,
          isVarified: shop.isVarified ?? 0!,
          retailer_data:shop.retailer_data??""
          )
          );
    }

    notifyListeners();
  }

  final List<DistributorList> _distributor = [];
  final List<HomePagedata> _homePagedata = [];

  List<HomePagedata> get getHomeData {
    return [..._homePagedata];
  }

  List<DistributorList> get distributor {
    return [..._distributor];
  }

  void makeDistributorList(DistributorData data) {
    print("kfjhgjkfjkhgkjfghgkfh ");
    _distributor.clear();

    for (var distributor in data.distributorList!.reversed!) 
    {
      _distributor.add(
        distributor

      //   Distributor(
      //   id: distributor.id,
      //   distributorAvatar: distributor.distributorAvatar ?? "",
      //   distributorOrgName: distributor.distributorOrgName ?? "",
      //   name: distributor.name ?? "",
      //   address: distributor.address ?? "",
      //   mail: distributor.mail ?? "",
      //   contactNumber: distributor.contactNumber ?? '',
      //   isActive: distributor.isActive ?? 0,
      //   createdAt: distributor.createdAt ?? "",
      //   distributorLongitude: distributor.distributorLongitude ?? "",
      //   distributorLatitude: distributor.distributorLatitude ?? "",
      //   isVarified: distributor.isVarified ?? 0,
      // )
      );
    }

    notifyListeners();
  }

  void stateList(HomePagedata data) {
    _homePagedata.clear();

    _homePagedata.add(HomePagedata(
        totalDistributors: data.totalDistributors,
        totalRetailers: data.totalRetailers));
    notifyListeners();
  }

  Future<DistributorModel> getDistributorList() async {
    print("check get all shop list data ");
    var uri = Uri.parse(APIURL.DISTRIBUTOR_LIST);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response >> ');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

      final responseJson = DistributorModel.fromJson(responseData);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        makeDistributorList(responseJson.result!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        return responseJson;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<HomePageModel> getStateList() async {
    var uri = Uri.parse(APIURL.GET_ALL_RETAILER_AND_DISTRI);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response >> ');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

      print("Checkdfdg leave data ${responseData}");
      final responseJson = HomePageModel.fromJson(responseData);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        stateList(responseJson.result!);
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
  }











}
