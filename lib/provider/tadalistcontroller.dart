import 'dart:convert';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/tadalist/tadalistresponse.dart';
import 'package:bmitserp/model/tada.dart';
import 'package:bmitserp/repositories/tadarepository.dart';
import 'package:bmitserp/screen/tadascreen/createtadascreen.dart';
import 'package:bmitserp/screen/tadascreen/edittadascreen.dart';
import 'package:bmitserp/screen/tadascreen/tadadetailscreen.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class TadaListController extends GetxController {
  final tadaList = <Tada>[].obs;
  TadaRepository repository = TadaRepository();

  Future<String> getTadaList() async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (result) {
      try {
        // EasyLoading.show(
        //     status: 'Loading, Please Wait...',
        //     maskType: EasyLoadingMaskType.black);

        final list = <Tada>[];

        final response = await repository.getTadaListdata();

        EasyLoading.dismiss(animation: true);

        for (var tada in response.data!.tadaList!) {
          list.add(Tada.list(tada.id!, tada.title!, tada.totalExpense!,
              tada.status!, tada.title!, ''));
        }

        tadaList.value = list;

        return "Loaded";
      } catch (e) {
        print(e);
        throw e;
      }
    } else {
      return "No Internet";
    }
  }

  void onTadaClicked(String id) {
    Get.to(TadaDetailScreen(),
        transition: Transition.cupertino, arguments: {"tadaId": id});
  }

  void onTadaEditClicked(String id) {
    Get.to(EditTadaScreen(),
        transition: Transition.cupertino, arguments: {"tadaId": id});
  }

  void onTadaCreateClicked() {
    Get.to(CreateTadaScreen(), transition: Transition.cupertino);
  }

  @override
  void onInit() {
    getTadaList();
    super.onInit();
  }
}
