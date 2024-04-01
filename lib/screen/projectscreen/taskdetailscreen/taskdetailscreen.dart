import 'package:bmitserp/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/widget/attachmentsection.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/widget/checklistsection.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/widget/confirmbottomsheet.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/widget/descriptionsection.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/widget/headersection.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/widget/teamsection.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Obx(() => Text(
                  controller.taskDetail.value.projectName!,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          ),
          bottomNavigationBar: Obx(
            () => controller.taskDetail.value.has_checklist == false &&
                    controller.taskDetail.value.status != "Completed"
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                useRootNavigator: true,
                                builder: (context) {
                                  return ConfirmBottomSheet();
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text("Mark as Finish"),
                          )),
                    ),
                  )
                : SizedBox.shrink(),
          ),
          body: Obx(
            () => SafeArea(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.getTaskOverview();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: controller.taskDetail.value.id != 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderSection(),
                              DescriptionSection(),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.white54,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TeamSection(),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.white54,
                              ),
                              AttachmentSection(),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.white54,
                              ),
                             // CommentSection(),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.white54,
                              ),
                              CheckListSection()
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ),
          )),
    );
  }
}
