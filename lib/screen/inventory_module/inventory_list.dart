import 'package:bmitserp/map/map_route.dart';
import 'package:bmitserp/provider/inventoryprovider.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/taskprovider.dart';
import 'package:bmitserp/screen/dashboard/attendancescreen.dart';
import 'package:bmitserp/screen/dashboard/leavescreen.dart';
import 'package:bmitserp/screen/inventory_module/advance_orcder_list.dart';
import 'package:bmitserp/screen/inventory_module/create_inventory.dart';
import 'package:bmitserp/screen/shop_module/create_shop_screen.dart';
import 'package:bmitserp/screen/shop_module/shop_list.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:bmitserp/widget/task_status/completed_task_screen.dart';
import 'package:bmitserp/widget/task_status/pending_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InventoryReport extends StatefulWidget {
  const InventoryReport({Key? key}) : super(key: key);

  @override
  State<InventoryReport> createState() => _InventoryReportState();
}

class _InventoryReportState extends State<InventoryReport> {
  var init = true;
  late BitmapDescriptor customIcon;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();
      init = false;
    }
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/icons/shop.png')
        .then((d) {
      customIcon = d;
    });
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final leaveProvider =
        Provider.of<InventoryProvider>(context, listen: false);
    final leaveData = await leaveProvider.getInventoryList();

    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    if (leaveData == 200) {}

    return "Loaded";
  }

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<InventoryProvider>(context, listen: true);
    final normalOrder = leaveData.normalOrderlist;
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Get.back();
            },
          ),
          title: Center(
            child: Text(
              "Inventory",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(CreateInventory());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    color: Colors.white24,
                    child: Text(
                      "Craete Inventory ",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            edgeOffset: 50,
            onRefresh: () async {
              await initialState();
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text("Normal Order"),
                  Card(
                    color: Colors.white12,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: normalOrder.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            child: Container(
                              color: Colors.white12,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          textBaseline: TextBaseline.alphabetic,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Order Date : ",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Text(
                                                    // "${messageTime(item.orderDate)}",
                                                    "lkfgdjh",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#036eb7"),
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // orders(item),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // showModalBottomSheet(
                                          //   elevation: 0,
                                          //   context: context,
                                          //   useRootNavigator: true,
                                          //   isScrollControlled: true,
                                          //   shape: const RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.only(
                                          //       topLeft: Radius.circular(20),
                                          //       topRight: Radius.circular(20),
                                          //     ),
                                          //   ),
                                          //   builder: (context) {
                                          //     return Padding(
                                          //       padding: MediaQuery.of(context).viewInsets,
                                          //       child: UpdateOrder(
                                          //           id: item.orderId!,
                                          //           item: item,
                                          //           retailer_id: retailer_id),
                                          //     );
                                          //   },
                                          // );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            color: Colors.orange,
                                            child: Text(
                                              "Sale Order",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    "Advance Order",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container();
                      //  Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(10),
                      //         bottomRight: Radius.circular(10)),
                      //     child: Container(
                      //       color: Colors.white12,
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 5, vertical: 10),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Expanded(
                      //                 child: Column(
                      //                   textBaseline: TextBaseline.alphabetic,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.baseline,
                      //                   children: [
                      //                     Row(
                      //                       children: [
                      //                         Text(
                      //                           "Order Date : ",
                      //                           maxLines: 1,
                      //                           style: TextStyle(
                      //                               color: Colors.white,
                      //                               fontSize: 15),
                      //                         ),
                      //                         Container(
                      //                           width: MediaQuery.of(context)
                      //                                   .size
                      //                                   .width /
                      //                               2.5,
                      //                           child: Text(
                      //                             "${messageTime(advancelist.orderDate)}",
                      //                             overflow:
                      //                                 TextOverflow.ellipsis,
                      //                             maxLines: 1,
                      //                             style: TextStyle(
                      //                                 color:
                      //                                     HexColor("#036eb7"),
                      //                                 fontSize: 14),
                      //                           ),
                      //                         ),
                      //                         Spacer(),
                      //                         Checkbox(
                      //                           focusColor: Colors.white,
                      //                           hoverColor: Colors.white,
                      //                           side: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 1.5,
                      //                           ),
                      //                           activeColor: Colors.white,
                      //                           checkColor: Colors.black,
                      //                           onChanged: (bool? value) {
                      //                             setState(() {
                      //                               advancelist.isSelected =
                      //                                   value;
                      //                             });
                      //                           },
                      //                           value: advancelist.isSelected,
                      //                         )
                      //                       ],
                      //                     ),
                      //                     orders(advancelist),
                      //                     Divider(),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            )),
      ),
    );

    //     DefaultTabController(
    //   length: 2,
    //   child: Container(
    //     decoration: RadialDecoration(),
    //     child: Scaffold(
    //       backgroundColor: Colors.transparent,
    //       appBar: AppBar(
    //         backgroundColor: Colors.transparent,
    //         leading: InkWell(
    //           child: Icon(
    //             Icons.arrow_back_ios,
    //             color: Colors.white,
    //           ),
    //           onTap: () {
    //             Get.back();
    //           },
    //         ),
    //         title: Center(
    //           child: Text(
    //             "Inventory",
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ),
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.all(15.0),
    //             child: GestureDetector(
    //               onTap: () {
    //                 Get.to(CreateInventory());
    //               },
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(10),
    //                 child: Container(
    //                   padding:
    //                       EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    //                   color: Colors.white24,
    //                   child: Text(
    //                     "Craete Inventory ",
    //                     style: TextStyle(color: Colors.white, fontSize: 12),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //       body: Padding(
    //         padding: const EdgeInsets.all(0.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SingleChildScrollView(
    //               // scrollDirection: Axis.horizontal,
    //               child: Padding(
    //                 padding: EdgeInsets.only(right: 2.w),
    //                 child: Container(
    //                   height: 50,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     color: Colors.transparent,
    //                   ),
    //                   child: TabBar(
    //                       unselectedLabelColor: Colors.redAccent,
    //                       indicatorSize: TabBarIndicatorSize.tab,
    //                       dividerColor: Colors.transparent,
    //                       indicator: BoxDecoration(
    //                           gradient: LinearGradient(
    //                               colors: [Colors.white10, Colors.white38]),
    //                           borderRadius: BorderRadius.circular(50),
    //                           color: Colors.redAccent),
    //                       tabs: [
    //                         Tab(
    //                           child: Align(
    //                             alignment: Alignment.center,
    //                             child: Text(
    //                               "Advance Order",
    //                               style: TextStyle(
    //                                   color: Colors.white, fontSize: 18),
    //                             ),
    //                           ),
    //                         ),
    //                         Tab(
    //                           child: Align(
    //                             alignment: Alignment.center,
    //                             child: Text(
    //                               'Normal Order',
    //                               style: TextStyle(
    //                                   color: Colors.white, fontSize: 18),
    //                             ),
    //                           ),
    //                         ),
    //                       ]),
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               child:
    //                   TabBarView(children: [LeaveScreen(), AttendanceScreen()]),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
