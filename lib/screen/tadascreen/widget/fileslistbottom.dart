import 'package:bmitserp/model/attachment.dart';
import 'package:flutter/material.dart';

class FilesListBottom extends StatelessWidget {
  List<Attachment> attachments;

  FilesListBottom(this.attachments);
  @override
  Widget build(BuildContext context) {
    final attachList = <Attachment>[];
    for (var attach in attachments) {
      if (attach.type == "file") {
        attachList.add(attach);
      }
    }
    return Container(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: attachList.length,
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Attachment item = attachList[index];
            return Card(
                elevation: 0,
                color: Colors.white12,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.url,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Icon(
                        Icons.download,
                        color: Colors.white,
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}
