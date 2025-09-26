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
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mamacare/app/data/models/user_model.dart';
// import 'package:mamacare/logger_debug.dart';
// import 'package:permission_handler/permission_handler.dart';

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

//   final isConnecting = false.obs;

//   Future<List<BluetoothDevice>> getPairedDevices() async {
//     // Request runtime permission
//     if (await Permission.bluetoothConnect.request().isDenied) {
//       Get.snackbar("Permission", "Bluetooth permission ditolak");
//       logger.d("Permission, Bluetooth permission ditolak");
//       return [];
//     }

//     try {
//       return await FlutterBluetoothSerial.instance.getBondedDevices();
//     } catch (e) {
//       Get.snackbar("Error", "Gagal ambil device: $e");
//       logger.d("erro : $e");
//       return [];
//     }
//   }

//   /// Kirim data ke device terpilih
//   Future<void> connectAndSend(BluetoothDevice device) async {
//     try {
//       isConnecting.value = true;
//       Get.snackbar("Connecting", "Menyambungkan ke ${device.name}...");

//       BluetoothConnection connection = await BluetoothConnection.toAddress(
//         device.address,
//       );

//       sendData(connection);

//       connection.finish();
//     } catch (e) {
//       Get.snackbar("Error", "Tidak bisa konek ke ${device.name}: $e");
//     } finally {
//       isConnecting.value = false;
//     }
//   }

//   void sendData(BluetoothConnection connection) {
//     try {
//       String jsonData =
//           '{"NAME":"BtJZWhnksOlqSK5YtDyO","ADMIN":"wDTXtckx9bNIuf2QKYNyn2W4ZZk1"}\n'; //demo
//       connection.output.add(utf8.encode(jsonData));
//       connection.output.allSent;
//       Get.snackbar("Sukses", "Data berhasil dikirim");
//     } catch (e) {
//       Get.snackbar("Error", "Gagal kirim data: $e");
//     }
//   }
// }
