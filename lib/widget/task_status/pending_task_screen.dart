import 'package:bmitserp/api/add_task_api.dart';
import 'package:bmitserp/provider/taskprovider.dart';
import 'package:bmitserp/utils/check_internet_connectvity.dart';
import 'package:bmitserp/widget/customalertdialog.dart';
import 'package:bmitserp/widget/task_status/pending_task_widegt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  MyTaskProvider _myTaskProvider = MyTaskProvider();
  final statusController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _myTaskProvider = Provider.of<MyTaskProvider>(context, listen: false);
    _myTaskProvider.getMyTask();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<InternetConnectionStatus>(context) ==
            InternetConnectionStatus.disconnected
        ? InternetNotAvailable()
        : Consumer<MyTaskProvider>(builder: (context, provider, child)
         {
            if (provider.taskListtData.isNotEmpty) 
            {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 1.h, bottom: 4.h, left: 1.w, right: 1.w),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: provider.taskListtData.length,
                          itemBuilder: (context, index) {
                            final data = provider.taskListtData[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white12,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 1.h,
                                    bottom: 1.h,
                                    left: 2.w,
                                    right: 2.w),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Task Name :",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              data.taskName.toString() ?? " ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.w,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Task Start Date :",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              DateFormat('MM/dd/yyyy hh:mm a')
                                                  .format(DateTime.parse(
                                                      DateTime.parse(data
                                                              .taskStartingDate
                                                              .toString())
                                                          .toLocal()
                                                          .toString())),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.w,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Task End Date :",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              //  widget.data.taskEndingDate.toString() ?? " ",
                                              DateFormat('MM/dd/yyyy hh:mm a')
                                                  .format(DateTime.parse(
                                                      DateTime.parse(data
                                                              .taskEndingDate
                                                              .toString())
                                                          .toLocal()
                                                          .toString())),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Submit Status",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              2)),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white)),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    statusController,
                                                                minLines: 4,
                                                                maxLines: 15,
                                                                validator:
                                                                    (value)
                                                                     {
                                                                  if (value
                                                                      .toString()
                                                                      .isEmpty) {
                                                                    return "Enter your notes ";
                                                                  }
                                                                  return null;
                                                                },
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration: const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        '',
                                                                    hintStyle: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            13)),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                          child: Text('cancle'),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                              updateTask(data.id
                                                                  .toString());
                                                            }
                                                          },
                                                          child: Text('Submit'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: Text(
                                        'Submit Status',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            ;
                          })),
                ),
              );
            } else {
              if (provider.datanotfound == false) {
                return SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                  color: Colors.white,
                )));
              } else {
                return Center(
                  child: Container(
                    child: Text(
                      "Sorry! Don't have a task ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            }
          });
  }

  updateTask(String taskId) async {
    EasyLoading.show(
        status: "Requesting...", maskType: EasyLoadingMaskType.black);
    var body = {"task_id": taskId, "note": statusController.text.toString()};

    UpdateTaskApi api = UpdateTaskApi(body);

    final response = await api.updateSetValue();

    if (response['status'] == "status" || response['status'] == "success") {
      EasyLoading.dismiss(animation: true);
      MyTaskProvider _myTaskProvider = MyTaskProvider();
      _myTaskProvider.getMyTask();
      setState(() {});

      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(response['message']),
            );
          });
    } else {
      setState(() {});

      EasyLoading.dismiss(animation: true);
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(response['message']),
            );
          });
    }
  }
}
