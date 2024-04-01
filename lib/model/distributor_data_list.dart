import 'package:flutter/material.dart';

class Distributor with ChangeNotifier {
  int? id;
  dynamic distributorAvatar;
  dynamic distributorOrgName;
  dynamic distributorLatitude;
  dynamic distributorLongitude;
  int? isVarified;
  dynamic name;
  dynamic address;
  dynamic mail;
  dynamic contactNumber;
  int? isActive;
  dynamic createdAt;

  Distributor({
    required this.id,
    required this.distributorAvatar,
    required this.distributorOrgName,
    required this.name,
    required this.address,
    required this.mail,
    required this.contactNumber,
    required this.isActive,
    required this.createdAt,
    required this.distributorLatitude,
    required this.distributorLongitude,
    required this.isVarified,
  });
}
