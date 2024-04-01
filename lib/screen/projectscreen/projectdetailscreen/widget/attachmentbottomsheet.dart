import 'package:bmitserp/screen/projectscreen/projectdetailscreen/widget/fileslistbottom.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/widget/imagelistbottom.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: RadialDecoration(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Attachments",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Image",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "Files",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: [
                  ItemListBottom(),
                  FilesListBottom(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
