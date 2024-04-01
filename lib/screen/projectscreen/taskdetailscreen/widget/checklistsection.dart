import 'package:bmitserp/model/checklist.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskDetailController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "Checklists",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(
          () => controller.taskDetail.value.checkList.length == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "No CheckList Found",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.taskDetail.value.checkList.length,
                  itemBuilder: (context, index) {
                    Checklist checklist =
                        controller.taskDetail.value.checkList[index];
                    var state = false.obs;
                    state.value = checklist.isCompleted == "0" ? false : true;
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      elevation: 0,
                      color: Colors.white10,
                      child: InkWell(
                        onTap: () async {
                          final response = await controller
                              .checkListToggle(checklist.id.toString());

                          if (response) {
                            state.value = !state.value;
                            checklist.isCompleted =
                                state.value == false ? "0" : "1";
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {},
                                  child: Icon(
                                    state == true
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: state == true
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(checklist.name,
                                    maxLines: 2,
                                    style: TextStyle(
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15)),
                              ),
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
