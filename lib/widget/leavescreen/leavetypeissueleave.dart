import 'package:bmitserp/model/leave.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class LeaveTypeIssueLeave extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeaveTypeIssueLeaveState();
}

class LeaveTypeIssueLeaveState extends State<LeaveTypeIssueLeave> {
  Leave? selectedValue;

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final provider = Provider.of<LeaveProvider>(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Leave Type',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: provider.selectleaveList
            .map((item) => DropdownMenuItem<Leave>(
                  value: item,
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          selectedValue = value as Leave?;
          if (selectedValue != null) {
            setState(() {});
          }
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: 160,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: HexColor("#036eb7"),
        ),
        buttonElevation: 0,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownWidth: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: HexColor("#036eb7"),
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }
}
