import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class WeeklyReportChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeeklyReportChartState();
}

class WeeklyReportChartState extends State<WeeklyReportChart> {
  int touchedGroupIndex = -1;

  var initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      Provider.of<DashboardProvider>(context, listen: false).buildgraph();
      initial = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 0,
          shape: ButtonBorder(),
          color: Colors.white12,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    makeTransactionsIcon(),
                    const SizedBox(
                      width: 38,
                    ),
                    const Text(
                      'Weekly',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'Reports',
                      style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      maxY: 13,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (_a, _b, _c, _d) => null,
                          ),
                          touchCallback: (FlTouchEvent event, response) {
                            if (response == null || response.spot == null) {
                              setState(() {
                                touchedGroupIndex = -1;
                                provider.showingBarGroups =
                                    List.of(provider.rawBarGroups);
                              });
                              return;
                            }

                            touchedGroupIndex =
                                response.spot!.touchedBarGroupIndex;

                            setState(() {
                              if (!event.isInterestedForInteractions) {
                                touchedGroupIndex = -1;
                                provider.showingBarGroups =
                                    List.of(provider.rawBarGroups);
                                return;
                              }
                              provider.showingBarGroups =
                                  List.of(provider.rawBarGroups);
                              if (touchedGroupIndex != -1) {
                                var sum = 0.0;
                                for (var rod in provider
                                    .showingBarGroups[touchedGroupIndex]
                                    .barRods) {
                                  sum += rod.toY;
                                }
                                final avg = sum /
                                    provider.showingBarGroups[touchedGroupIndex]
                                        .barRods.length;

                                provider.showingBarGroups[touchedGroupIndex] =
                                    provider.showingBarGroups[touchedGroupIndex]
                                        .copyWith(
                                  barRods: provider
                                      .showingBarGroups[touchedGroupIndex]
                                      .barRods
                                      .map((rod) {
                                    return rod.copyWith(toY: avg);
                                  }).toList(),
                                );
                              }
                            });
                          }),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 42,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: provider.showingBarGroups,
                      gridData: FlGridData(
                          show: false,
                          horizontalInterval: 2,
                          verticalInterval: 2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    if (value == 0) {
      text = '1Hr';
    } else if (value == 2) {
      text = '2Hr';
    } else if (value == 4) {
      text = '4Hr';
    } else if (value == 6) {
      text = '6Hr';
    } else if (value == 8) {
      text = '8Hr';
    } else if (value == 10) {
      text = '10Hr';
    } else if (value == 12) {
      text = '12Hr';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<String> titles = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 15,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 25,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 15,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
