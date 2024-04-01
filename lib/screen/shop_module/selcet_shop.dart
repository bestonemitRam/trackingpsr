import 'dart:io';

import 'package:bmitserp/model/leave.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/screen/shop_module/shop_dropdown.dart';
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
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectShop extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectShopState();
}

class SelectShopState extends State<SelectShop> {
  final List<String> items = ['1 liter', '5 ml', '200 ml'];
// Initially selected value
  List<String> itemslist = ['Item 1'];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
          decoration: RadialDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
           Card(
            shape: ButtonBorder(),
            elevation: 0,
            color: Colors.white12,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShopDropDown(),
                  Card(
                    shape: ButtonBorder(),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            child: Text(
                              "Jira       ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            width: 20.w,
                            child: Column(
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  width: 15.w,
                                  height: 5.h,
                                  child: TextField(
                                    maxLines: 1,
                                    cursorHeight: 18,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: Platform.isIOS
                                        ? TextInputType.numberWithOptions(
                                            signed: true,
                                            decimal: true,
                                          )
                                        : TextInputType.number,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.1.h,
                                      ),
                                      hintText: "0",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Container(
                          //   // width: 10.w,
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Type",
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(0.0),
                          //         child: DropdownButton<String>(
                          //           hint: Text('Select '),
                          //           value: null,
                          //           underline:
                          //               Container(), // Hides the dropdown underline
                          //           onChanged: (String? value) {
                          //             print('Selected: $value');
                          //           },
                          //           items: items.map((String item) {
                          //             return DropdownMenuItem<String>(
                          //               value: item,
                          //               child: Text(item),
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: ButtonBorder(),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            child: Text(
                              " 1 liter Water  ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            width: 20.w,
                            child: Column(
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  width: 15.w,
                                  height: 5.h,
                                  child: TextField(
                                    maxLines: 1,
                                    cursorHeight: 18,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: Platform.isIOS
                                        ? TextInputType.numberWithOptions(
                                            signed: true,
                                            decimal: true,
                                          )
                                        : TextInputType.number,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.1.h,
                                      ),
                                      hintText: "0",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Container(
                          //   // width: 10.w,
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Type",
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(0.0),
                          //         child: DropdownButton<String>(
                          //           hint: Text('Select '),
                          //           value: null,
                          //           underline:
                          //               Container(), // Hides the dropdown underline
                          //           onChanged: (String? value) {
                          //             print('Selected: $value');
                          //           },
                          //           items: items.map((String item) {
                          //             return DropdownMenuItem<String>(
                          //               value: item,
                          //               child: Text(item),
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          // Spacer(),
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         itemslist
                          //             .add('Item ${itemslist.length + 1}');
                          //       });
                          //     },
                          //     child: Icon(
                          //       Icons.add,
                          //       size: 30,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: ButtonBorder(),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            child: Text(
                              "500 ml Water",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            width: 20.w,
                            child: Column(
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  width: 15.w,
                                  height: 5.h,
                                  child: TextField(
                                    maxLines: 1,
                                    cursorHeight: 18,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: Platform.isIOS
                                        ? TextInputType.numberWithOptions(
                                            signed: true,
                                            decimal: true,
                                          )
                                        : TextInputType.number,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.1.h,
                                      ),
                                      hintText: "0",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Container(
                          //   // width: 10.w,
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Type",
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(0.0),
                          //         child: DropdownButton<String>(
                          //           hint: Text('Select '),
                          //           value: null,
                          //           underline:
                          //               Container(), // Hides the dropdown underline
                          //           onChanged: (String? value) {
                          //             print('Selected: $value');
                          //           },
                          //           items: items.map((String item) {
                          //             return DropdownMenuItem<String>(
                          //               value: item,
                          //               child: Text(item),
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          // Spacer(),
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         itemslist
                          //             .add('Item ${itemslist.length + 1}');
                          //       });
                          //     },
                          //     child: Icon(
                          //       Icons.add,
                          //       size: 30,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: ButtonBorder(),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            child: Text(
                              "250 ml Water",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            width: 20.w,
                            child: Column(
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  width: 15.w,
                                  height: 5.h,
                                  child: TextField(
                                    maxLines: 1,
                                    cursorHeight: 18,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: Platform.isIOS
                                        ? TextInputType.numberWithOptions(
                                            signed: true,
                                            decimal: true,
                                          )
                                        : TextInputType.number,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.1.h,
                                      ),
                                      hintText: "0",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Container(
                          //   // width: 10.w,
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         "Type",
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(0.0),
                          //         child: DropdownButton<String>(
                          //           hint: Text('Select '),
                          //           value: null,
                          //           underline:
                          //               Container(), // Hides the dropdown underline
                          //           onChanged: (String? value) {
                          //             print('Selected: $value');
                          //           },
                          //           items: items.map((String item) {
                          //             return DropdownMenuItem<String>(
                          //               value: item,
                          //               child: Text(item),
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          // Spacer(),
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         itemslist
                          //             .add('Item ${itemslist.length + 1}');
                          //       });
                          //     },
                          //     child: Icon(
                          //       Icons.add,
                          //       size: 30,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Expanded(
                  //       child: ListView.builder(
                  //         itemCount: itemslist.length,
                  //         itemBuilder: (context, index) {
                  //           return
                  //           Card
                  //           (
                  //             shape: ButtonBorder(),
                  //             color: Colors.transparent,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Row(
                  //                 children: [
                  //                   Text(
                  //                     "Water",
                  //                     style: TextStyle(
                  //                         color: Colors.white, fontSize: 18),
                  //                   ),
                  //                   Container(
                  //                     width: 20.w,
                  //                     child: Column(
                  //                       children: [
                  //                         Text(
                  //                           "Quantity",
                  //                           style: TextStyle(
                  //                               color: Colors.white),
                  //                         ),
                  //                         Container(
                  //                           padding:
                  //                               const EdgeInsets.symmetric(
                  //                                   vertical: 5),
                  //                           width: 15.w,
                  //                           height: 5.h,
                  //                           child: TextField(
                  //                             maxLines: 1,
                  //                             cursorHeight: 18,
                  //                             style: TextStyle(
                  //                                 color: Colors.white),
                  //                             keyboardType: Platform.isIOS
                  //                                 ? TextInputType
                  //                                     .numberWithOptions(
                  //                                     signed: true,
                  //                                     decimal: true,
                  //                                   )
                  //                                 : TextInputType.number,
                  //                             textAlign: TextAlign.center,
                  //                             textAlignVertical:
                  //                                 TextAlignVertical.center,
                  //                             decoration: InputDecoration(
                  //                               contentPadding:
                  //                                   EdgeInsets.symmetric(
                  //                                 vertical: 0.1.h,
                  //                               ),
                  //                               hintText: "00",
                  //                               border: OutlineInputBorder(),
                  //                               focusedBorder:
                  //                                   OutlineInputBorder(),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Container(
                  //                     // width: 10.w,
                  //                     child: Column(
                  //                       children: [
                  //                         Text(
                  //                           "Type",
                  //                           style: TextStyle(
                  //                               color: Colors.white),
                  //                         ),
                  //                         Padding(
                  //                           padding:
                  //                               const EdgeInsets.all(0.0),
                  //                           child: DropdownButton<String>(
                  //                             hint: Text('Select '),
                  //                             value: null,
                  //                             underline:
                  //                                 Container(), // Hides the dropdown underline
                  //                             onChanged: (String? value) {
                  //                               print('Selected: $value');
                  //                             },
                  //                             items: items.map((String item) {
                  //                               return DropdownMenuItem<
                  //                                   String>(
                  //                                 value: item,
                  //                                 child: Text(item),
                  //                               );
                  //                             }).toList(),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 20,
                  //                   ),
                  //                   Spacer(),
                  //                   Align(
                  //                     alignment: Alignment.bottomRight,
                  //                     child: InkWell(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           itemslist.add(
                  //                               'Item ${itemslist.length + 1}');
                  //                         });
                  //                       },
                  //                       child: Icon(
                  //                         Icons.add,
                  //                         size: 30,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )),
   
   
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
