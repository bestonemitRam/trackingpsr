import 'dart:io';

import 'package:bmitserp/data/source/network/controller/retailer_controller.dart';
import 'package:bmitserp/model/DataModel.dart';
import 'package:bmitserp/model/order_list.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/productprovider.dart';

import 'package:bmitserp/screen/shop_module/create_shop_screen.dart';
import 'package:bmitserp/screen/shop_module/selcet_shop.dart';
import 'package:bmitserp/screen/shop_module/shop_list.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/leavescreen/issueleavesheet.dart';
import 'package:bmitserp/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpdateOrder extends StatefulWidget {
  final int id;
  final OderListData item;
  final int retailer_id;
  UpdateOrder(
      {super.key,
      required this.id,
      required this.item,
      required this.retailer_id});

  @override
  State<UpdateOrder> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateOrder> {
  final RetailerController controller = Get.put(RetailerController());

  var init = true;
  var isVisible = false;
  bool isdata = false;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();
      init = false;
    }
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final leaveProvider = Provider.of<ProductProvider>(context, listen: false);
    final leaveData = await leaveProvider.getProductList();
    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    // if (leaveData.statusCode != 200) {
    //   showToast(leaveData!.message!);
    // }

    return "Loaded";
  }

  List<String> items = [];
  @override
  void initState() {
    isdata = true;
    super.initState();
    items.add('Item ${items.length + 1}');

    controller.shopItems.clear();
  }

  final _form = GlobalKey<FormState>();

  List<TextEditingController> _textEditingController = [];
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<ProductProvider>(context, listen: true);
    final shops = leaveData.productlist;
    if (isdata) {
   
      for (var item in shops) {
        TextEditingController controller = TextEditingController();
        for (var data in widget.item!.orderDetails!) {
          if (item.inventoryId.toString() == data.inventoryId.toString()) {
            controller.text = data.totalOrders.toString();
            item.quantity = int.parse(data.totalOrders.toString());
            break;
          } else {}
        }
        _textEditingController.add(controller);
      }
    }

    return Container(
      decoration: RadialDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create Order',
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
              Obx(() => Form(
                    key: _form,
                    child: controller.imageFile.value == null
                        ? Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45.h,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: shops.length,
                                  itemBuilder: (context, index) {
                                    final item = shops[index];

                                    return Card(
                                      shape: ButtonBorder(),
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 65.w,
                                              child: Text(
                                                item.productName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Container(
                                              width: 20.w,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Case / ${item.availableQuantity}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    width: 15.w,
                                                    height: 5.h,
                                                    child: TextField(
                                                      maxLines: 1,
                                                      controller:
                                                          _textEditingController[
                                                              index],
                                                      cursorHeight: 18,
                                                      onChanged: (newValue) {
                                                        if (int.tryParse(
                                                                    newValue) !=
                                                                null &&
                                                            int.parse(
                                                                    newValue) >
                                                                int.parse(item
                                                                    .availableQuantity)) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Please check your available Quantity ",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0,
                                                          );

                                                          setState(() {
                                                            _textEditingController[
                                                                    index]
                                                                .text = "0";
                                                          });
                                                        }

                                                        // setState(() {

                                                        setState(() {
                                                          isdata = false;
                                                        });

                                                        item.quantity =
                                                            int.parse(newValue);
                                                        // });
                                                      },
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      keyboardType: Platform
                                                              .isIOS
                                                          ? TextInputType
                                                              .numberWithOptions(
                                                              signed: true,
                                                              decimal: true,
                                                            )
                                                          : TextInputType
                                                              .number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      // textAlignVertical: TextAlignVertical.center,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          vertical: 0.1.h,
                                                        ),
                                                        hintText: "0",
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        border:
                                                            OutlineInputBorder(),
                                                        //  focusedBorder: OutlineInputBorder(

                                                        //  ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: HexColor("#036eb7"),
                                        shape: ButtonBorder(),
                                        fixedSize: Size(double.maxFinite, 55)),
                                    onPressed: () async {
                                      bool status =
                                          await controller.updateOrder(
                                              shops, widget.item.orderId!);
                                      if (status) {
                                        Provider.of<ProductProvider>(context,
                                                listen: false)
                                            .getOrderList(widget.retailer_id);
                                        Get.back();
                                      }
                                    },
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ],
                          )
                        : SizedBox(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}

// Scaffold(

//     backgroundColor: Colors.transparent,
//     bottomNavigationBar: Padding(
//       padding: const EdgeInsets.all(20),
//       child: TextButton(
//           style: TextButton.styleFrom(
//               backgroundColor: HexColor("#036eb7"),
//               shape: ButtonBorder(),
//               fixedSize: Size(double.maxFinite, 55)),
//           onPressed: () {
//             //validateValue();
//           },
//           child: const Text(
//             'Submit',
//             style: TextStyle(color: Colors.white),
//           )),
//     ),
//     body:
//     Container(
//         child: Card(

//       elevation: 0,
//       color: Colors.white12,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         child: ListView.builder(
//           itemCount: shops.length,
//           itemBuilder: (context, index) {
//             final item = shops[index];
//             return Card(
//               shape: ButtonBorder(),
//               color: Colors.transparent,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 65.w,
//                       child: Text(
//                         item.productName,
//                         style: TextStyle(
//                             color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 3.w,
//                     ),
//                     Container(
//                       width: 20.w,
//                       child: Column(
//                         children: [
//                           Text(
//                             "Case / ${item.availableQuantity}",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(vertical: 5),
//                             width: 15.w,
//                             height: 5.h,
//                             child: TextField(
//                               maxLines: 1,
//                               cursorHeight: 18,
//                               style: TextStyle(color: Colors.white),
//                               keyboardType: Platform.isIOS
//                                   ? TextInputType.numberWithOptions(
//                                       signed: true,
//                                       decimal: true,
//                                     )
//                                   : TextInputType.number,
//                               textAlign: TextAlign.center,
//                               textAlignVertical:
//                                   TextAlignVertical.center,
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: 0.1.h,
//                                 ),
//                                 hintText: "0",
//                                 hintStyle:
//                                     TextStyle(color: Colors.white),
//                                 border: OutlineInputBorder(),
//                                 focusedBorder: OutlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     ))));
