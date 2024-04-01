import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String value;
  final String title;

  CardTitle(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}