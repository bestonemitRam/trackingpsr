import 'package:flutter/material.dart';

class LeaveListCardView extends StatelessWidget {
  final String name;
  final String avatar;
  final String post;
  final String leaveDays;

  LeaveListCardView(this.name, this.avatar, this.post, this.leaveDays);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white12,
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                avatar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  post,
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
              ],
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        leaveDays,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Days',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
