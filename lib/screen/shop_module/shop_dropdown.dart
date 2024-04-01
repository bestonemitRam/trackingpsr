import 'package:bmitserp/model/leave.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/utils/navigationservice.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/customalertdialog.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShopDropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShopDropDownState();
}

class ShopDropDownState extends State<ShopDropDown> {
  Leave? selectedValue;

  bool isLoading = false;

  TextEditingController endDate = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController startDate = TextEditingController();

  void issueLeave() async {
    if (endDate.text.isNotEmpty &&
        startDate.text.isNotEmpty &&
        reason.text.isNotEmpty &&
        selectedValue != null) {
      try {
        // showLoader();
        // isLoading = true;
        // final response =  await Provider.of<LeaveProvider>(context, listen: false).issueLeave(
        //         startDate.text, endDate.text, reason.text, selectedValue!.id);

        // if (!mounted) {
        //   return;
        // }
        // dismissLoader();
        // Navigator.of(context).pop();
        // Navigator.pop(context);
        // isLoading = false;
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return Dialog(
        //       child: CustomAlertDialog(response.message),
        //     );
        //   },
        // );
      } catch (e) {
        dismissLoader();
        isLoading = false;
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(e.toString()),
            );
          },
        );
      }
    } else {
      NavigationService()
          .showSnackBar("Leave Status", "Field must not be empty");
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
          status: "Requesting...", maskType: EasyLoadingMaskType.black);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveProvider>(context);
    return WillPopScope(
        onWillPop: () async {
          return !isLoading;
        },
        child: Container());

    //   Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //     child: SafeArea(
    //       child: Container(
    //           width: MediaQuery.of(context).size.width,
    //           child: DropdownButtonHideUnderline(
    //             child: DropdownButton2(
    //               isExpanded: true,
    //               hint: Row(
    //                 children: const [
    //                   Expanded(
    //                     child: Text(
    //                       'Select Shop ',
    //                       style: TextStyle(
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.black,
    //                       ),
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               items: provider.selectleaveList
    //                   .where((element) => element.status)
    //                   .map((item) => DropdownMenuItem<Leave>(
    //                         value: item,
    //                         child: Text(
    //                           item.name,
    //                           style: const TextStyle(
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.black,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ))
    //                   .toList(),
    //               value: selectedValue,
    //               onChanged: (value) {
    //                 selectedValue = value as Leave?;
    //                 if (selectedValue != null) {
    //                   setState(() {});
    //                 }
    //               },
    //               icon: const Icon(
    //                 Icons.arrow_forward_ios_outlined,
    //               ),
    //               iconSize: 14,
    //               iconEnabledColor: Colors.black,
    //               iconDisabledColor: Colors.grey,
    //               buttonHeight: 50,
    //               buttonWidth: 160,
    //               buttonPadding: const EdgeInsets.only(left: 14, right: 14),
    //               buttonDecoration: BoxDecoration(
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(10),
    //                     topRight: Radius.circular(0),
    //                     bottomLeft: Radius.circular(0),
    //                     bottomRight: Radius.circular(10)),
    //                 color: HexColor("#FFFFFF"),
    //               ),
    //               buttonElevation: 0,
    //               itemHeight: 40,
    //               itemPadding: const EdgeInsets.only(left: 14, right: 14),
    //               dropdownMaxHeight: 200,
    //               dropdownPadding: null,
    //               dropdownDecoration: BoxDecoration(
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(0),
    //                     topRight: Radius.circular(10),
    //                     bottomLeft: Radius.circular(10),
    //                     bottomRight: Radius.circular(10)),
    //                 color: HexColor("#FFFFFF"),
    //               ),
    //               dropdownElevation: 8,
    //               scrollbarRadius: const Radius.circular(40),
    //               scrollbarThickness: 6,
    //               scrollbarAlwaysShow: true,
    //               offset: const Offset(0, 0),
    //             ),
    //           )),
    //     ),
    //   ),
    // );
  }
}
