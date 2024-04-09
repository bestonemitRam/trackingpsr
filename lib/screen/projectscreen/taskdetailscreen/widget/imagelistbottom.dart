import 'package:bmitserp/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/utils/navigationservice.dart';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_notification/in_app_notification.dart';

import '../../../../model/attachment.dart';

class ItemListBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskDetailController model = Get.find();
    final attachments = <Attachment>[];

    for (var attachment in model.taskDetail.value.attachments) {
      if (attachment.type == "image") {
        attachments.add(attachment);
      }
    }
    return Container(
      padding: EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: List.generate(attachments.length, (index) {
          final attachment = attachments[index];
          return GestureDetector(
              onTap: () {
                final imageProvider = Image.network(attachment.url).image;
                showImageViewer(context, imageProvider, swipeDismissible: true,
                    onViewerDismissed: () {
              
                });
              },
              child: Stack(children: [
                Image.network(
                  attachment.url,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        model.launchUrls(attachment.url);
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.blueAccent,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ]));
        }),
      ),
    );
  }
}
