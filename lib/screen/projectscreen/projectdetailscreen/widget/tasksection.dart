import 'package:bmitserp/model/task.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/taskdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "Tasks",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(
          () => ListView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.project.value.tasks.length,
            itemBuilder: (context, index) {
              Task task = model.project.value.tasks[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 0,
                color: Colors.white10,
                child: GestureDetector(
                  onTap: () {
                    Get.to(TaskDetailScreen(), arguments: {"id": task.id});
                  },
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(task.name!,
                                maxLines: 2,
                                style: TextStyle(
                                    height: 1.2,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15)),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10)),
                          child: Container(
                            width: 10,
                            color: task.status == "Completed"
                                ? Colors.green
                                : Colors.orangeAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
