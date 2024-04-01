import 'package:flutter/material.dart';

class Shop with ChangeNotifier {
  int? id;
  dynamic retailerName;
  dynamic retailerShopName;
  dynamic retailerAddress;
  dynamic retailerLatitude;
  dynamic retailerLongitude;
  dynamic retailerShopImage;
  dynamic retailer_mobile_number;
  int? isVarified;
  dynamic retailer_data;

  Shop(
      {required this.id,
      required this.retailerName,
      required this.retailerShopName,
      required this.retailerAddress,
      required this.retailerLatitude,
      required this.retailerLongitude,
      required this.retailerShopImage,
      required this.retailer_mobile_number,
      required this.isVarified,
      required this.retailer_data});
}
