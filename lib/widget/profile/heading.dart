import 'dart:io';

import 'package:bmitserp/provider/profileprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Heading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeadingState();
}

class HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    final provider = Provider.of<ProfileProvider>(context, listen: false);
    final profile = Provider.of<ProfileProvider>(context).profile;
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  // final ImagePicker _picker = ImagePicker();
                  // final XFile? image = await _picker.pickImage(
                  //     source: ImageSource.gallery,
                  //     imageQuality: 50,
                  //     maxWidth: 500);
                  // if (image != null)
                  //  {
                  //   setState(() async {
                  //     EasyLoading.show(
                  //         status: 'Changing....',
                  //         maskType: EasyLoadingMaskType.black);
                  //     try {
                  //       isLoading = true;
                  //       await provider.updateProfile(
                  //           '', '', '', '', '', '', File(image.path));
                  //     } catch (e) {}
                  //     isLoading = false;
                  //     EasyLoading.dismiss(animation: true);
                  //   });
                  // }
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(profile.avatar))),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black12,
                          padding: const EdgeInsets.all(20),
                          child: const Text('',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: profile.name != "null"
                    ? Text(
                        profile.name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Center(),
              ),
              Container(
                child: profile.username != "null"
                    ? Text(
                        profile.username,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    : Center(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  profile.email,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
