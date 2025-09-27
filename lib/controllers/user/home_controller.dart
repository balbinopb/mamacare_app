
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mamacare/models/line_chart_model.dart';
import 'package:mamacare/models/risk_card_model.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeController extends GetxController {
  final name = "Steffanyy Martin".obs;
  final date = "01 Juni 2025".obs;
  final hour = "09.30 AM".obs;

  final risk = RiskCardModel(
    title: "Preeclampsia",
    level: "High Risk",
    heartbeatPattern: [2, 2, 3, 1, 4, 0, 2, 2],
  ).obs;

  final chartData = LineChartModel(
    title: 'MAP & ROT Graphic',
    entries: [
      LineChartEntry(
        label: 'MAP',
        color: Colors.red,
        spots: [
          FlSpot(0, 15),
          FlSpot(1, 25),
          FlSpot(2, 35),
          FlSpot(3, 65),
          FlSpot(4, 85),
          FlSpot(5, 100),
        ],
      ),
      LineChartEntry(
        label: 'ROT',
        color: Colors.amber,
        spots: [
          FlSpot(0, 5),
          FlSpot(1, 15),
          FlSpot(2, 45),
          FlSpot(3, 95),
          FlSpot(4, 65),
          FlSpot(5, 100),
        ],
      ),
    ],
  ).obs;
}



