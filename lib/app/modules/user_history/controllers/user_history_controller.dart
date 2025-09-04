import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/data/models/line_chart_model.dart';

class UserHistoryController extends GetxController {
  var selectedFilter = 'All'.obs;
  List<String> filters = ['All', 'Normal', 'Moderate', 'High'];

  final data = [
    {
      'title': 'Preeclampsia High Risk',
      'time': '10.30 AM',
      'date': '01 Juni 2025',
      'level': 'High',
    },
    {
      'title': 'Preeclampsia Moderate Risk',
      'time': '10.28 AM',
      'date': '01 Juni 2025',
      'level': 'Moderate',
    },
    {
      'title': 'Preeclampsia Normal Risk',
      'time': '10.28 AM',
      'date': '01 Juni 2025',
      'level': 'Normal',
    },
  ];

  List<Map<String, String>> get filteredData {
    if (selectedFilter.value == 'All') return data;
    return data.where((item) => item['level'] == selectedFilter.value).toList();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  Color getColor(String level) {
    switch (level) {
      case 'High':
        return Colors.red.shade100;
      case 'Moderate':
        return Colors.yellow.shade100;
      case 'Normal':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getIconColor(String level) {
    switch (level) {
      case 'High':
        return Colors.red;
      case 'Moderate':
        return Colors.yellow;
      case 'Normal':
        return Colors.green;
      default:
        return Colors.grey.shade200;
    }
  }

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
