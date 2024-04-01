import 'package:bmitserp/provider/holidayprovider.dart';
import 'package:bmitserp/widget/holiday/holidaycard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HolidayCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final holidayList = Provider.of<HolidayProvider>(context).holidayList;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: holidayList.length,
          itemBuilder: (ctx, i) {
            return Holidaycard(
                id: holidayList[i].id,
                name: holidayList[i].title,
                month: holidayList[i].month,
                day: holidayList[i].day,
                desc: holidayList[i].description);
          }),
    );
  }
}
