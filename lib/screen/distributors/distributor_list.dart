import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/screen/distributors/distributorList_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DistributorLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context, listen: true);
    final distributor = leaveData.distributor;

    if (distributor.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: distributor.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DistributorScreenListData(
                id: distributor[i].id ?? 0,
                distributorAvatar: distributor[i].distributorAvatar ?? "",
                distributorOrgName: distributor[i].distributorOrgName ?? '',
                fullName: distributor[i].name ?? "",
                address: distributor[i].address ?? '',
                mail: distributor[i].mail ?? "",
                contact: distributor[i].contactNumber ?? '',
                isActive: distributor[i].isActive ?? 0,
                createdAt: distributor[i].createdAt ?? "",
                is_varified: distributor[i].isVarified ?? 0,
                distributorList: distributor[i],
              ),
            );
          });
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Center(
          child: Text(
            "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
