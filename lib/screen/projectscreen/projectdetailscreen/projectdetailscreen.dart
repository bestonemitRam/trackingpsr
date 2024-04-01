import 'package:bmitserp/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/widget/attachmentsection.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/widget/descriptionsection.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/widget/headersection.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/widget/tasksection.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/widget/teamsection.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(ProjectDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () {
                return model.getProjectOverview();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
                    child: model.project.value.id == 0
                        ? SizedBox()
                        : Column(
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
                              Obx(() => model.project.value.tasks.length != 0
                                  ? TaskSection()
                                  : SizedBox())
                            ],
                          ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
