import 'dart:io';

import 'package:bmitserp/data/source/network/controller/retailer_controller.dart';
import 'package:bmitserp/model/DataModel.dart';
import 'package:bmitserp/model/advance_order.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateInventory extends StatefulWidget {
  CreateInventory({
    super.key,
  });

  @override
  State<CreateInventory> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreateInventory> {
  final RetailerController controller = Get.put(RetailerController());

  var init = true;
  var isVisible = false;

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
    leaveProvider.getAdvanceList();

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
    // TODO: implement initState
    super.initState();
    items.add('Item ${items.length + 1}');

    controller.shopItems.clear();
  }

  final _form = GlobalKey<FormState>();

  List<TextEditingController> _textEditingController = [];
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<ProductProvider>(context, listen: true);
    final product = leaveData.productlist;
    final advanceOrder = leaveData.advanceDataList;

    return Container(
      decoration: RadialDecoration(),
      child: Container(
        decoration: RadialDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Scaffold(
            backgroundColor: Colors.transparent,
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
                  "Create Inventory",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  () => controller.imageFiless.value == null
                      ? TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("#036eb7"),
                              shape: ButtonBorder(),
                              fixedSize: Size(double.maxFinite, 55)),
                          onPressed: () {
                            controller.createInventorydata(product, advanceOrder);
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ))
                      : Center(),
                )),
            body:
             SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      final item = product[index];
                      _textEditingController.add(TextEditingController());
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
                                      color: Colors.white, fontSize: 18),
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      width: 15.w,
                                      height: 5.h,
                                      child: TextField(
                                        maxLines: 1,
                                        controller:
                                            _textEditingController[index],
                                        cursorHeight: 18,
                                        onChanged: (newValue) {
                                          print(item.availableQuantity);
                                          if (int.tryParse(newValue) != null &&
                                              int.parse(newValue) >
                                                  int.parse(
                                                      item.availableQuantity)) {
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Please check your available Quantity ",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );

                                            setState(() {
                                              _textEditingController[index]
                                                  .text = "0";
                                            });
                                          }

                                          // controller.retailer_id.value =
                                          //     widget.id;

                                          setState(() {
                                            item.quantity = int.parse(newValue);
                                          });
                                        },
                                        style: TextStyle(color: Colors.white),
                                        keyboardType: Platform.isIOS
                                            ? TextInputType.numberWithOptions(
                                                signed: true,
                                                decimal: true,
                                              )
                                            : TextInputType.number,
                                        textAlign: TextAlign.center,
                                        // textAlignVertical: TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.1.h,
                                          ),
                                          hintText: "0",
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          border: OutlineInputBorder(),
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
                      ;
                    },
                  ),
                  Text(
                    "Is Advance Order",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: advanceOrder.length, // Example itemCount
                    itemBuilder: (context, index) {
                      final advancelist = advanceOrder[index];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  "${messageTime(advancelist.orderDate)}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#036eb7"),
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Spacer(),
                                              Checkbox(
                                                focusColor: Colors.white,
                                                hoverColor: Colors.white,
                                                side: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.5,
                                                ),
                                                activeColor: Colors.white,
                                                checkColor: Colors.black,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    advancelist.isSelected =
                                                        value;
                                                  });
                                                },
                                                value: advancelist.isSelected,
                                              )
                                            ],
                                          ),
                                          orders(advancelist),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
     
     
     
      ),
    );
  }

  Widget orders(AdvanceDataList advancelist) {
    return advancelist.orderDetails!.isNotEmpty
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: advancelist.orderDetails!.length,
            itemBuilder: (context, index) {
              final data = advancelist.orderDetails![index];
              return Padding(
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

  static String messageTime(String time) {
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

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
