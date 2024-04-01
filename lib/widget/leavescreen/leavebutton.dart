import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/utils/navigationservice.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/leavescreen/earlyleavesheet.dart';
import 'package:bmitserp/widget/leavescreen/issueleavesheet.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class LeaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(right: 5),
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: HexColor("#036eb7"), shape: ButtonBorder()),
              onPressed: () {
                showModalBottomSheet(
                    elevation: 0,
                    context: context,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: IssueLeaveSheet(),
                      );
                    });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Request Leave',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        )),
        // Expanded(
        //     child: Padding(
        //   padding: EdgeInsets.only(left: 5),
        //   child: TextButton(
        //       style: TextButton.styleFrom(
        //           backgroundColor: HexColor("#036eb7"), shape: ButtonBorder()),
        //       onPressed: () {
        //         if (provider.attendanceList['check-in'] != '-' &&
        //             provider.attendanceList['check-out'] == '-') {
        //           showModalBottomSheet(
        //               elevation: 0,
        //               context: context,
        //               useRootNavigator: true,
        //               isScrollControlled: true,
        //               shape: const RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.only(
        //                       topLeft: Radius.circular(20),
        //                       topRight: Radius.circular(20))),
        //               builder: (context) {
        //                 return Padding(
        //                   padding: MediaQuery.of(context).viewInsets,
        //                   child: EarlyLeaveSheet(),
        //                 );
        //               });
        //         } else {
        //           NavigationService().showSnackBar(
        //               "Leave Alert", "You are not bound to office time");
        //         }
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: const Text(
        //           'Early Leave',
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       )),
        // )),
      ],
    );
  }
}
