import 'package:bmitserp/api/add_task_api.dart';
import 'package:bmitserp/model/my_task.dart';
import 'package:bmitserp/provider/taskprovider.dart';
import 'package:bmitserp/widget/customalertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PendingTaskWidget extends StatefulWidget {
  final TaskListPending data;
  final bool type;

  PendingTaskWidget({super.key, required this.data, required this.type});

  @override
  State<PendingTaskWidget> createState() => _PendingTaskWidgetState();
}

class _PendingTaskWidgetState extends State<PendingTaskWidget> {
  final statusController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white12,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 1.h, bottom: 1.h, left: 2.w, right: 2.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Task Name :",
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      widget.data.taskName.toString() ?? " ",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
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
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.parse(
                          DateTime.parse(
                                  widget.data.taskStartingDate.toString())
                              .toLocal()
                              .toString())),
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
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
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      // widget.data.taskEndingDate.toString() ?? " ",
                      DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.parse(
                          DateTime.parse(widget.data.taskEndingDate.toString())
                              .toLocal()
                              .toString())),
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
