import 'package:bmitserp/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCardView extends StatelessWidget {
  final int index;
  final String date;
  final String day;
  final String start;
  final String end;

  AttendanceCardView(this.index, this.date, this.day, this.start, this.end);
  static String dateTime(String time) {
    print("fdgdhfgi ${time}");
    DateTime dt = DateTime.parse(time);
    print("converted gmt date >> " + dt.toString());
    final localTime = dt.toLocal();
    print("local modified date >> " + localTime.toString());

    var inputDate = DateTime.parse(localTime.toString());
    var outputFormat = DateFormat('MM-dd-yyyy hh:mm a').format(inputDate);

    return outputFormat;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white12,
      shape: ButtonBorder(),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                      DateFormat('dd-MM-yyyy').format(DateTime.parse(date)),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      textAlign: TextAlign.start),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(day,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      textAlign: TextAlign.start),
                ),
              ),
              Expanded(
                  child: Container(
                child: Text(dateTime(start ?? '0000-00-00 00:00:00'),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    textAlign: TextAlign.start),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                    //   dateTime(end ?? '0000-00-00 00:00:00'
                    // ),
                    end,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    textAlign: TextAlign.start),
              )),
            ],
          )),
    );
  }
}
