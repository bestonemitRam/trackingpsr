import 'package:bmitserp/provider/holidayprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleHoliday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HolidayProvider>(context);
    return Center(
      child: ToggleSwitch(
        activeBgColor: [Colors.white12],
        activeFgColor: Colors.white,
        inactiveFgColor: Colors.white,
        inactiveBgColor: Colors.transparent,
        minWidth: 100,
        minHeight: 45,
        initialLabelIndex: provider.toggleValue,
        totalSwitches: 2,
        onToggle: (index) {
          provider.toggleValue = index!;
          provider.holidayListFilter();
        },
        labels: const ['Upcoming', 'Past'],
      ),
    );
  }
}
