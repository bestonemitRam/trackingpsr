import 'package:bmitserp/model/attachment.dart';
import 'package:bmitserp/utils/navigationservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:in_app_notification/in_app_notification.dart';

class ItemListBottom extends StatelessWidget {
  List<Attachment> attachments;

  ItemListBottom(this.attachments);
  @override
  Widget build(BuildContext context) {
    final attachList = <Attachment>[];
    for (var attach in attachments) {
      if (attach.type == "image") {
        attachList.add(attach);
      }
    }

    return Container(
      padding: EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: List.generate(attachList.length, (index) {
          Attachment item = attachList[index];
          return GestureDetector(
              onTap: () {
                final imageProvider = Image.network(item.url).image;
                showImageViewer(context, imageProvider, swipeDismissible: true,
                    onViewerDismissed: () {
                
                });
              },
              child: Stack(children: [
                Image.network(
                  item.url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        FileDownloader.downloadFile(
                            url:
                                "https://media.geeksforgeek.org/wp-content/uploads/20201210102727/Screenshot708.jpg",
                            name: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            onProgress: (fileName, progress) {
                             
                              InAppNotification.show(
                                child: Card(
                                  margin: const EdgeInsets.all(15),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    leading: Container(
                                        height: double.infinity,
                                        child: Icon(Icons.download)),
                                    iconColor: HexColor("#011754"),
                                    textColor: HexColor("#011754"),
                                    minVerticalPadding: 10,
                                    minLeadingWidth: 0,
                                    tileColor: Colors.white,
                                    title: Text("Downloading"),
                                    subtitle: Text(
                                      "${fileName} is downloading",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                context: NavigationService
                                    .navigatorKey.currentState!.context,
                              );
                            },
                            onDownloadCompleted: (String path) {
                              InAppNotification.show(
                                child: Card(
                                  margin: const EdgeInsets.all(15),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    leading: Container(
                                        height: double.infinity,
                                        child: Icon(Icons.download)),
                                    iconColor: HexColor("#011754"),
                                    textColor: HexColor("#011754"),
                                    minVerticalPadding: 10,
                                    minLeadingWidth: 0,
                                    tileColor: Colors.white,
                                    title: Text("Downloaded"),
                                    subtitle: Text(
                                      "Download completed",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                context: NavigationService
                                    .navigatorKey.currentState!.context,
                              );
                            },
                            onDownloadError: (String error) {
                     
                              InAppNotification.show(
                                child: Card(
                                  margin: const EdgeInsets.all(15),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    leading: Container(
                                        height: double.infinity,
                                        child: Icon(Icons.download)),
                                    iconColor: HexColor("#011754"),
                                    textColor: HexColor("#011754"),
                                    minVerticalPadding: 10,
                                    minLeadingWidth: 0,
                                    tileColor: Colors.white,
                                    title: Text("Failed"),
                                    subtitle: Text(
                                      "File Download Failed",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                context: NavigationService
                                    .navigatorKey.currentState!.context,
                              );
                            });
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.black,
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
