import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:flutter/material.dart';
import 'package:bmitserp/widget/homescreen/cardoverview.dart';
import 'package:provider/provider.dart';

class OverviewDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _overview = Provider.of<DashboardProvider>(context).overviewList;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardOverView(
                  type: 'Present',
                  value: _overview['present']!,
                  icon: Icons.work),
              CardOverView(
                  type: 'Holidays',
                  value: _overview['holiday']!,
                  icon: Icons.celebration)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardOverView(
                  type: 'Leave',
                  value: _overview['leave']!,
                  icon: Icons.person_off),
              CardOverView(
                  type: 'Tasks',
                  value: _overview['total_task']!,
                  icon: Icons.outlined_flag_sharp)
              // CardOverView(
              //     type: 'Request',
              //     value: _overview['request']!,
              //     icon: Icons.pending)
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     CardOverView(
          //         type: 'Projects',
          //         value: _overview['total_project']!,
          //         icon: Icons.work_history_outlined),
          //     CardOverView(
          //         type: 'Tasks',
          //         value: _overview['total_task']!,
          //         icon: Icons.outlined_flag_sharp)
          //   ],
          // ),
        ],
      ),
    );
  }
}
