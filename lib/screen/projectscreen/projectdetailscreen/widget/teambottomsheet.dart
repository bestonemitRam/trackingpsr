import 'package:bmitserp/model/member.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamBottomSheet extends StatelessWidget {
  List<Member> leaders;
  List<Member> members;

  TeamBottomSheet(this.leaders, this.members);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: RadialDecoration(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Team Lead(s)",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  itemCount: leaders.length,
                  itemBuilder: (ctx, i) => Padding(
                      padding: EdgeInsets.all(5), child: teamCard(leaders[i]))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Team Member(s)",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  itemCount: members.length,
                  itemBuilder: (ctx, i) => Padding(
                      padding: EdgeInsets.all(5), child: teamCard(members[i]))),
            ],
          ),
        ),
      ),
    );
  }

  Widget teamCard(Member member) {
    return Card(
      shape: ButtonBorder(),
      elevation: 0,
      color: Colors.white10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                member.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      member.name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(member.post, style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
