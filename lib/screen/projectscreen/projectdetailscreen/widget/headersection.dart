import 'package:bmitserp/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectDetailController model = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Obx(() => Text(model.project.value.priority)),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              model.project.value.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Row(
                  children: [
                    Text(
                      "Due Date:  ",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                        model.project.value.date,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Obx(
                  () => Text(
                    model.project.value.status,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
