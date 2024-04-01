import 'package:bmitserp/model/month.dart';
import 'package:bmitserp/provider/attendancereportprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class AttendanceToggle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AttendanceToggleState();
}

class AttendanceToggleState extends State<AttendanceToggle> {
  var initial = true;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AttendanceReportProvider>(context, listen: true);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Attendance History',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Consumer(
            builder: (context, value, child) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: (provider.month)
                      .map((item) => DropdownMenuItem<Month>(
                            value: item,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: provider.month[provider.selectedMonth],
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      provider.selectedMonth = (value as Month).index;
                      provider.getAttendanceReport();
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 40,
                  buttonWidth: 110,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10)),
                    color: HexColor("#FFFFFF"),
                  ),
                  buttonElevation: 0,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: HexColor("#FFFFFF"),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(0, 0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
