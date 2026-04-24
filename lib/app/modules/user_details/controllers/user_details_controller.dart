import 'dart:async';
// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/data/models/line_chart_model.dart';
import 'package:mamacare/app/data/models/risk_card_model.dart';
import 'package:mamacare/app/data/models/user_model.dart';

class UserDetailsController extends GetxController {
  var currentTime = ''.obs;
  late final String adminId;
  late final UserModel user;
  static const int totalWeeks = 40;
  final ScrollController weekScrollController = ScrollController();
  bool hasAutoScrolledToLatestWeek = false;

  var sensorData = Rxn<Map<String, dynamic>>();
  var userData = Rxn<Map<String, dynamic>>();

  var selectedWeek = totalWeeks.obs;

  @override
  void onClose() {
    weekScrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    _updateTime();

    try {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args != null) {
        adminId = args['adminId'] as String? ?? '';
        final argUser = args['user'];
        if (argUser is UserModel && adminId.isNotEmpty) {
          user = argUser;
          fetchLatestSensorData(adminId, user.id);

          // Load latest bucket week by default
          fetchWeekSensorData(adminId, user.id, totalWeeks);
        } else {
          print('Error: Missing user or adminId');
        }
      } else {
        print('Error: No arguments provided');
      }
    } catch (e) {
      print('Error in onInit: $e');
    }
  }

  // untuk ambil data dari sub-collection 'readSensor'
  Future<void> fetchLatestSensorData(String adminId, String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('sensorData')
        .doc(adminId)
        .collection('users')
        .doc(userId)
        .collection('readsensor')
        .limit(1)
        .get();

    sensorData.value = snapshot.docs.isNotEmpty
        ? snapshot.docs.first.data()
        : null;
  }

  // unntuk ambil data user info
  Future<Map<String, dynamic>?> fetchUserData(
    String adminId,
    String userId,
  ) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('sensorData')
          .doc(adminId)
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // load userdata
  Future<void> loadUserData(String adminId, String userId) async {
    final data = await fetchUserData(adminId, userId);
    userData.value = data;
  }

  void _updateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a  dd MMMM yyyy').format(now);
  }

  final risk = RiskCardModel(
    title: "Preeclampsia",
    level: "High Risk",
    heartbeatPattern: [2, 2, 3, 1, 4, 0, 2, 2],
  ).obs;

  final chartData = Rx<LineChartModel>(
    LineChartModel(title: 'MAP & ROT Graphic', entries: []),
  );

  // Store all sensor data for filtering by week
  List<Map<String, dynamic>> allSensorData = [];

  void selectWeek(int weekNumber) {
    selectedWeek.value = weekNumber;
    _updateChartForWeek(weekNumber);
  }

  void autoScrollWeekChipsToSelectedWeek() {
    if (hasAutoScrolledToLatestWeek) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!weekScrollController.hasClients) return;

      const chipExtent = 63.0; // 51 width + 12 right padding
      final selectedIndex = selectedWeek.value - 1;
      final targetOffset = (selectedIndex * chipExtent).toDouble();
      final maxOffset = weekScrollController.position.maxScrollExtent;

      weekScrollController.animateTo(
        targetOffset.clamp(0.0, maxOffset),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );

      hasAutoScrolledToLatestWeek = true;
    });
  }

  void _updateChartForWeek(int weekNumber) {
    final filtered = _getDataForWeek(weekNumber);

    final mapSpots = <FlSpot>[];
    final rotSpots = <FlSpot>[];

    for (int i = 0; i < filtered.length; i++) {
      final data = filtered[i];
      final mapVal = (data['MAP_Supine'] as num?)?.toDouble() ?? 0.0;
      final rotVal = (data['MAP_ROT'] as num?)?.toDouble() ?? 0.0;
      mapSpots.add(FlSpot(i.toDouble(), mapVal));
      rotSpots.add(FlSpot(i.toDouble(), rotVal));
    }

    chartData.value = LineChartModel(
      title: 'MAP & ROT (Week $weekNumber)',
      entries: [
        LineChartEntry(label: 'MAP', color: AppColors.red, spots: mapSpots),
        LineChartEntry(label: 'ROT', color: Colors.amber, spots: rotSpots),
      ],
    );
  }

  List<Map<String, dynamic>> _getDataForWeek(int weekNumber) {
    if (allSensorData.isEmpty) return [];

    final sorted = List<Map<String, dynamic>>.from(allSensorData);
    sorted.sort((a, b) {
      final aDate = _extractDate(a['createAt']);
      final bDate = _extractDate(b['createAt']);
      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;
      return aDate.compareTo(bDate);
    });

    final safeWeek = weekNumber.clamp(1, totalWeeks);
    final bucketSize = (sorted.length / totalWeeks).ceil();
    final start = (safeWeek - 1) * bucketSize;

    if (start >= sorted.length) return [];

    final end = (start + bucketSize) > sorted.length
        ? sorted.length
        : (start + bucketSize);

    return sorted.sublist(start, end);
  }

  DateTime? _extractDate(dynamic timestamp) {
    if (timestamp is DateTime) return timestamp;
    if (timestamp is Timestamp) return timestamp.toDate();
    return null;
  }

  int _latestWeekWithData() {
    if (allSensorData.isEmpty) return 1;

    final bucketSize = (allSensorData.length / totalWeeks).ceil();
    if (bucketSize <= 0) return 1;

    final latestWeek = ((allSensorData.length - 1) ~/ bucketSize) + 1;
    return latestWeek.clamp(1, totalWeeks);
  }

  Future<void> fetchWeekSensorData(
    String adminId,
    String userId,
    int weekNumber,
  ) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('sensorData')
          .doc(adminId)
          .collection('users')
          .doc(userId)
          .collection('readsensor')
          .orderBy('createAt')
          .get();

      // Store all data
      allSensorData = snapshot.docs.map((doc) => doc.data()).toList();

      final latestWeek = _latestWeekWithData();
      final safeWeek = weekNumber.clamp(1, latestWeek);

      selectedWeek.value = safeWeek;
      _updateChartForWeek(safeWeek);
    } catch (e) {
      print('ERROR fetching sensor data: $e');
      chartData.value = LineChartModel(
        title: 'MAP & ROT (Week $weekNumber)',
        entries: [],
      );
    }
  }

  void listenToSensorData(String adminId, String userId) {
    FirebaseFirestore.instance
        .collection('sensorData')
        .doc(adminId)
        .collection('users')
        .doc(userId)
        .collection('readsensor')
        .orderBy('createAt', descending: true)
        .limit(10)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.docs.isEmpty) return;

          final docs = snapshot.docs.reversed.toList();
          final mapSpots = <FlSpot>[];
          final rotSpots = <FlSpot>[];

          for (int i = 0; i < docs.length; i++) {
            final data = docs[i].data();
            final mapVal = (data['MAP_Supine'] ?? 0).toDouble();
            final rotVal = (data['MAP_ROT'] ?? 0).toDouble();
            mapSpots.add(FlSpot(i.toDouble(), mapVal));
            rotSpots.add(FlSpot(i.toDouble(), rotVal));
          }

          chartData.value = LineChartModel(
            title: 'MAP & ROT Graphic',
            entries: [
              LineChartEntry(
                label: 'MAP',
                color: AppColors.red,
                spots: mapSpots,
              ),
              LineChartEntry(
                label: 'ROT',
                color: Colors.amber,
                spots: rotSpots,
              ),
            ],
          );
        });
  }
}
