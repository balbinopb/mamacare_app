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

  var sensorData = Rxn<Map<String, dynamic>>();
  var userData = Rxn<Map<String, dynamic>>();

  var selectedWeek = 9.obs;

  @override
  void onInit() {
    super.onInit();

    _updateTime();
    final args = Get.arguments as Map<String, dynamic>;
    adminId = args['adminId'];
    user = args['user'];

    fetchLatestSensorData(adminId, user.id);
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

  void selectWeek(int weekNumber) {
    selectedWeek.value = weekNumber;
    fetchWeekSensorData(adminId, user.id, weekNumber);
  }

  Future<void> fetchWeekSensorData(
    String adminId,
    String userId,
    int weekNumber,
  ) async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(
      Duration(days: 7 * (DateTime.now().weekday - 1)),
    );
    final selectedStart = startOfWeek.subtract(
      Duration(days: 7 * (9 - weekNumber)),
    ); // =============assuming week 9 is current===================================
    final selectedEnd = selectedStart.add(const Duration(days: 7));

    final snapshot = await FirebaseFirestore.instance
        .collection('sensorData')
        .doc(adminId)
        .collection('users')
        .doc(userId)
        .collection('readsensor')
        .where('createAt', isGreaterThanOrEqualTo: selectedStart)
        .where('createAt', isLessThanOrEqualTo: selectedEnd)
        .orderBy('createAt')
        .get();

    final mapSpots = <FlSpot>[];
    final rotSpots = <FlSpot>[];

    for (int i = 0; i < snapshot.docs.length; i++) {
      final data = snapshot.docs[i].data();
      final mapVal = (data['MAP_Supine'] ?? 0).toDouble();
      final rotVal = (data['MAP_ROT'] ?? 0).toDouble();
      mapSpots.add(FlSpot(i.toDouble(), mapVal));
      rotSpots.add(FlSpot(i.toDouble(), rotVal));
    }

    // chartData.value = LineChartModel(
    //   title: 'MAP & ROT (Week $weekNumber)',
    //   entries: [
    //     LineChartEntry(label: 'MAP', color: AppColors.red, spots: mapSpots),
    //     LineChartEntry(label: 'ROT', color: Colors.amber, spots: rotSpots),
    //   ],
    // );
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
