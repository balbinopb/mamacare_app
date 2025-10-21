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


  // Future<Map<String,dynamic>> dataToSend(Map<String,dynamic> args) async {
  //   final userId = args['userId'];
  //   final adminId = args['userId'];
  //   final userData= await FirebaseFirestore.instance.collection("sensorData").doc(adminId).collection("users").doc(userId).get();

  //   // calculate imt/bmi for sending to esp
  //   double imt= (userData['weight'] / (userData['height'] * userData['height']));

  //   // create map
  //   Map<String,dynamic> data= {"userId": userId,"adminId": adminId,"userImt": imt,"userAge": userData['age']};

  //   return data;
  // }


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

  final chartData = LineChartModel(
    title: 'MAP & ROT Graphic',
    entries: [
      LineChartEntry(
        label: 'MAP',
        color: AppColors.red,
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
