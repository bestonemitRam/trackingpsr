import 'dart:convert';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/hollidays/HolidayResponse.dart';
import 'package:bmitserp/data/source/network/model/hollidays/Holidays.dart';
import 'package:bmitserp/model/holiday.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HolidayProvider with ChangeNotifier {
  final List<Holiday> _holidayList = [];
  final List<Holiday> _holidayListdata = [];
  final List<Holiday> _holidayListFilter = [];
  List<Holiday> get holidayList {
    return _holidayListFilter;
  }

  int toggleValue = 0;

  void holidayListFilter() {
    _holidayListFilter.clear();
    if (toggleValue == 0) {
      // _holidayListFilter.addAll(_holidayList .where((element) => element.dateTime.isAfter(DateTime.now()))
      //     .toList());
      _holidayListFilter.addAll(_holidayList);
    } else {
      // _holidayListFilter.addAll(_holidayList .where((element) => element.dateTime.isBefore(DateTime.now()))
      //     .toList().reversed);

      _holidayListFilter.addAll(_holidayListdata);
    }
    notifyListeners();
  }

  Future<HolidayResponse> getHolidays() async 
  {
    var uri = Uri.parse(APIURL.HOLIDAYS_API);

    Preferences preferences = Preferences();
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
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = HolidayResponse.fromJson(responseData);

        makeHolidayList(responseJson.data);
        makeHolidayListData(responseJson.data);
        holidayListFilter();

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  void makeHolidayList(Data? data) {
    _holidayList.clear();
    for (var item in data!.upcomingHoliday ?? []) {
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(item.holidayDate);
      print(DateFormat('MMMM').format(tempDate));
      _holidayList.add(Holiday(
          id: item.id,
          day: tempDate.day.toString(),
          month: DateFormat('MMM').format(tempDate),
          title: item.holidayName,
          description: item.holidayDate,
          dateTime: tempDate));
    }
    notifyListeners();
  }

  void makeHolidayListData(Data? data) {
    _holidayListdata.clear();
    for (var item in data!.pastHoliday ?? []) {
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(item.holidayDate);
      print(DateFormat('MMMM').format(tempDate));
      _holidayListdata.add(Holiday(
          id: item.id,
          day: tempDate.day.toString(),
          month: DateFormat('MMM').format(tempDate),
          title: item.holidayName,
          description: item.holidayDate,
          dateTime: tempDate));
    }
    notifyListeners();
  }
}
