import 'dart:async';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/network/controller/retailer_controller.dart';
import 'package:bmitserp/model/order_list.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/productprovider.dart';
import 'package:bmitserp/screen/genrateOrder/order_genrate_ui.dart';
import 'package:bmitserp/screen/genrateOrder/order_list_screen.dart';
import 'package:bmitserp/screen/genrateOrder/update_order.dart';
import 'package:bmitserp/screen/shop_module/create_shop_screen.dart';
import 'package:bmitserp/screen/shop_module/edit_retailer.dart';
import 'package:bmitserp/utils/SingleImageView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NormalOrderlist extends StatelessWidget {
  
  
  final RetailerController controller = Get.put(RetailerController());

  static String messageTime(String time) 
  {
    DateTime dt = DateTime.parse(time);
    print("converted gmt date >> " + dt.toString());
    final localTime = dt.toLocal();
    print("local modified date >> " + localTime.toString());

    var inputDate = DateTime.parse(localTime.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');

    var outputDate = outputFormat.format(inputDate);

    String formattedTime = DateFormat('dd-MM-yyyy ').format(inputDate);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return 
    ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order Date : ",
                            maxLines: 1,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text(
                             // "${messageTime(item.orderDate)}",
                             "lkfgdjh",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: HexColor("#036eb7"), fontSize: 14),
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
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.orange,
                      child: Text(
                        "Sale Order",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
             
              ],
            )
         
          ],
        ),
      ),
    );
  
  
  }

  Widget orders(OderListData item) {
    return item.orderDetails!.isNotEmpty
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: item.orderDetails!.length,
            itemBuilder: (context, index) {
              final data = item.orderDetails![index];
              return 
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Text(
                      "${data.product} ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    // Text(
                    //   "${data.product}",
                    //   style: TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                    // ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Total Order : ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Container(
                                child: Text(
                                  "${data.totalOrders} case",
                                  style: TextStyle(
                                      color: HexColor("#036eb7"), fontSize: 14),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
           
            },
          )
        : Center();
  }
}
