import 'package:bmitserp/provider/attendancereportprovider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class AttendanceStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = Provider.of<AttendanceReportProvider>(context).todayReport;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Check in | Check out',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20.0),
              child: LinearPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 30.0,
                  padding: EdgeInsets.all(0),
                  percent: status['production_percent']!,
                  center: Text(
                    status['production_hour']!,
                    style: TextStyle(color: Colors.white),
                  ),
                  barRadius: const Radius.circular(20),
                  backgroundColor: HexColor("#3dFFFFFF"),
                  progressColor: status['check_in_at'] != "-" &&
                          status['check_out_at'] == "-"
                      ? HexColor("#e82e5f").withOpacity(.5)
                      : HexColor("#3b98cc")),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      status['check_in_at']!,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      status['check_out_at']!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
