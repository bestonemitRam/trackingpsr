import 'package:bmitserp/screen/projectscreen/projectlistscreen/projectlistscrreencontroller.dart';
import 'package:bmitserp/screen/projectscreen/projectlistscreen/widget/projectcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProjectListScreenController model = Get.find();
    return Obx(
      () => model.filteredList.isEmpty
          ? SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(),
            )
          : ListView.builder(
              primary: false,
              itemCount: model.filteredList.length,
              itemBuilder: (context, index) {
                final item = model.filteredList[index];
                return ProjectCard(item);
              },
            ),
    );
  }
}
