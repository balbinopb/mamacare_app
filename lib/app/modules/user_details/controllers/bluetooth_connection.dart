import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BluetoothConnection extends GetxController {
  static const platform = MethodChannel('com.example.mamacare/bluetooth');

  var pairedDevices = <Map<String, dynamic>>[].obs;
  var isConnecting = false.obs;

  Future<void> getPairedDevices() async {
    try {
      final devices = await platform.invokeMethod('getPairedDevices');
      pairedDevices.value = List<Map<String, dynamic>>.from(devices);
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal ambil perangkat: ${e.message}");
    }
  }

  Future<void> connectToDevice(String address) async {
    try {
      isConnecting.value = true;
      final result = await platform.invokeMethod('connect', {
        "address": address,
      });
      Get.snackbar("Bluetooth", result);
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal koneck: ${e.message}");
    } finally {
      isConnecting.value = false;
    }
  }

  // Send data to connected device
  Future<void> sendData(String message) async {
    try {
      await platform.invokeMethod('sendData', {"message": message});
      Get.snackbar("Bluetooth", "Data terkirim");
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal kirim data: ${e.message}");
    }
  }

  // Disconnect
  Future<void> disconnect() async {
    try {
      await platform.invokeMethod('disconnect');
      Get.snackbar("Bluetooth", "Terputus dari perangkat");
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal putuskan koneksi: ${e.message}");
    }
  }
}
