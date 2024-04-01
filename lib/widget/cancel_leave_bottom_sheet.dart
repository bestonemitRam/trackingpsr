import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/utils/navigationservice.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:bmitserp/widget/buttonborder.dart';

class CancelLeaveBottomSheet extends StatefulWidget {
  int id;

  CancelLeaveBottomSheet(this.id);

  @override
  State<StatefulWidget> createState() => CancelLeaveBottomSheetState(id);
}

class CancelLeaveBottomSheetState extends State<CancelLeaveBottomSheet> {
  int id;

  CancelLeaveBottomSheetState(this.id);

  void logout() async {
    try {
      setState(() {
        showLoader();
      });
      final leaveData = Provider.of<LeaveProvider>(context, listen: false);

      final response = await leaveData.cancelLeave(id);

      setState(() {
        dismissLoader();
      });
      if (!mounted) {
        return;
      }
      if (response.status == true) {
        NavigationService()
            .showSnackBar("Leave Status", "Leave cancelled successfully");
        Navigator.pop(context);
        await leaveData.getLeaveTypeDetail();
      }
    } catch (e) {
      NavigationService().showSnackBar("Cancel Leave", e.toString());
      setState(() {
        dismissLoader();
      });
    }
  }

  void dismissLoader() {
    setState(() {
      EasyLoading.dismiss(animation: true);
    });
  }

  void showLoader() {
    setState(() {
      EasyLoading.show(
          status: "Canceling, Please Wait..",
          maskType: EasyLoadingMaskType.black);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cancel Leave',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Are you sure you wanna cancel the leave?',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("#036eb7"),
                              shape: ButtonBorder()),
                          onPressed: () async {
                            logout();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("#036eb7"),
                              shape: ButtonBorder()),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              'Go back',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
