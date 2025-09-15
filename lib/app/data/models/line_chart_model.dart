
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartModel {
  final String title;
  final List<LineChartEntry> entries;

  LineChartModel({required this.title, required this.entries});
}

class LineChartEntry {
  final String label;
  final Color color;
  final List<FlSpot> spots;

  LineChartEntry({
    required this.label,
    required this.color,
    required this.spots,
  });
}