import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/widget/leave_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveListDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context, listen: true);
    final leaves = leaveData.leaveList;
    if (leaves.isNotEmpty) {
      return GridView.builder(
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: leaves.length,
          padding: EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: leaves[i],
                child: LeaveRow(leaves[i].id, leaves[i].name,
                    leaves[i].allocated, leaves[i].total),
              ));
    } else {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Currently don't have a leave ",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}
