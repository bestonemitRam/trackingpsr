import 'package:bmitserp/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/widget/attachmentbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskDetailController model = Get.find();
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(AttachmentBottomSheet(),
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: true,
            ignoreSafeArea: true);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Attachments",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Show Media  ->",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(height: 10),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Files/Images ( ${model.taskDetail.value.attachments.length} )",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
