import 'package:bmitserp/provider/profileprovider.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/cartTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile =
        Provider.of<ProfileProvider>(context, listen: false).profile;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Card(
        shape: ButtonBorder(),
        color: Colors.white10,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle('Bank name', profile.bankName),
              CardTitle('Account Number', profile.bankNumber),
              CardTitle('Joined Date', profile.joinedDate),
            ],
          ),
        ),
      ),
    );
  }
}
