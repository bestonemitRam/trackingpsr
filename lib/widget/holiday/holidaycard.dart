import 'package:bmitserp/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class Holidaycard extends StatelessWidget {
  final int id;
  final String name;
  final String month;
  final String day;
  final String desc;

  Holidaycard(
      {required this.id,
      required this.name,
      required this.month,
      required this.day,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ButtonBorder(),
      elevation: 0,
      color: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                shape: ButtonBorder(),
                elevation: 0,
                color: Colors.blueAccent,
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(month, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      softWrap: true,
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      parse(desc).body!.text,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
