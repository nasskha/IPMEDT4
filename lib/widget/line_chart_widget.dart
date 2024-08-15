import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> points;
  final String selectedTimeline;
  final List<Color> gradientColors = [
    const Color(0xFFA26769),
    const Color(0xFFF4A88A),
  ];

  LineChartWidget({super.key, required this.points, required this.selectedTimeline});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: selectedTimeline == 'Week' ? 6 : (selectedTimeline == 'Month' ? 29 : 364),
          minY: 1,
          maxY: 8,
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  if (selectedTimeline == 'Week') {
                    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    if (value >= 0 && value < 7) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(days[value.toInt()]),
                      );
                    }
                  } else if (selectedTimeline == 'Month') {
                    if (value >= 0 && value < 30 && value % 5 == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text((value).toInt().toString()),
                      );
                    }
                  } else if (selectedTimeline == 'Year') {
                    if (value >= 0 && value < 365 && value % 30 == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text((value / 30).toInt().toString()),
                      );
                    }
                  }
                  return Container();
                },
                interval: selectedTimeline == 'Week' ? 1 : (selectedTimeline == 'Month' ? 5 : 30),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  if (value >= 1 && value <= 8 && value == value.toInt()) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(value.toInt().toString()),
                    );
                  }
                  return Container();
                },
                interval: 1,
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return const FlLine(
                color: Color(0xffe7e8ec),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return const FlLine(
                color: Color(0xffe7e8ec),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xffe7e8ec), width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: points,
              isCurved: true,
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
