import 'package:bmitserp/model/attachment.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:bmitserp/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:get/get.dart';

class ItemListBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    final attachments = <Attachment>[];

    for (var attachment in model.project.value.attachment) {
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
