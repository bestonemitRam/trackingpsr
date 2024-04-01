import 'package:bmitserp/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskDetailController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "Description",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(
          () => ReadMoreText(
            parse(controller.taskDetail.value.description).body!.text,
            trimLines: 4,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Show more',
            trimExpandedText: ' Show less',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.normal),
            lessStyle: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            moreStyle: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
