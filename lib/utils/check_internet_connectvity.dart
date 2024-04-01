import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class InternetNotAvailable extends StatelessWidget {
  double? height;
  InternetNotAvailable({super.key, double? height});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 55.h,
        width: 50.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/no_internet.png',
              ),
              Text(
                "No Internet connection, Please check your connection",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
