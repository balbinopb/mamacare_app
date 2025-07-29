import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HistoryController extends GetxController {
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
}
