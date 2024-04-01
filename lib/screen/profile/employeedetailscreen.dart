import 'package:bmitserp/provider/employeedetailcontroller.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/cartTitle.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(EmployeeDetailController());
    return Obx(
      () => Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(model.profile.value.name == ""
                ? "Profile"
                : model.profile.value.name),
          ),
          resizeToAvoidBottomInset: true,
          body: RefreshIndicator(
            onRefresh: () {
              return model.getEmployeeDetail(Get.arguments["employeeId"]);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(
                () => Column(
                  children: [
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              model.profile.value.avatar))),
                                  alignment: Alignment.bottomCenter,
                                )),
                          ],
                        ),
                      ),
                    ),
                    model.profile.value.post != ''
                        ? Container(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20, bottom: 10),
                            width: double.infinity,
                            child: const Text(
                              'Personal Details',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    model.profile.value.post != ''
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            child: Card(
                              shape: ButtonBorder(),
                              color: Colors.white10,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CardTitle(
                                        'Fullname', model.profile.value.name),
                                    CardTitle('Username',
                                        model.profile.value.username),
                                    CardTitle(
                                        'Phone', model.profile.value.phone),
                                    CardTitle('Post', model.profile.value.post),
                                    CardTitle('Date of birth',
                                        model.profile.value.dob),
                                    CardTitle(
                                        'Gender', model.profile.value.gender),
                                    CardTitle(
                                        'Address', model.profile.value.address),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
