import 'package:bmitserp/provider/tadadetailcontroller.dart';
import 'package:bmitserp/screen/tadascreen/widget/attachmentbottomsheet.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class TadaDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(TadaDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Obx(
        () => SafeArea(
          child: model.isLoading.value
              ? SizedBox.shrink()
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "TADA Detail",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  bottomNavigationBar: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      child: Row(
                        children: [
                          Card(
                            elevation: 0,
                            color: model.tada.value.status == "Pending"
                                ? Colors.orange.shade500
                                : model.tada.value.status == "Rejected"
                                    ? Colors.red.shade500
                                    : Colors.green.shade500,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(model.tada.value.status,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Total ",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          Text("Rs " + model.tada.value.expenses,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                  body: Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: Text(
                              model.tada.value.submittedDate!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Title",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            model.tada.value.title,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            parse(model.tada.value.description ?? "")
                                .body!
                                .text,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  AttachmentBottomSheet(
                                      model.tada.value.attachments!),
                                  isDismissible: true,
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  ignoreSafeArea: true);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Attachments ( ${model.tada.value.attachments!.length.toString()} )",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Show Media",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "${model.tada.value.verifiedBy}",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          if (model.tada.value.verifiedBy != "")
                            Text(
                              parse(model.tada.value.remark ?? "N/A")
                                  .body!
                                  .text,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
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
