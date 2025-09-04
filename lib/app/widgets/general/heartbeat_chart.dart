import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mamacare/app/constants/app_colors.dart';

class HeartbeatChart extends StatelessWidget {
  final List<double> pattern;

  const HeartbeatChart({super.key, required this.pattern});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98,
      width: 139,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: false,
              color: AppColors.white,
              barWidth: 2,
              spots: [
                for (int i = 0; i < pattern.length; i++)
                  FlSpot(i.toDouble(), pattern[i]),
              ],
              dotData: FlDotData(show: false),
            ),
          ],
          minX: 0,
          maxX: pattern.length.toDouble() - 1,
          minY: 0,
          maxY: 5,
        ),
      ),
    );
  }
}
