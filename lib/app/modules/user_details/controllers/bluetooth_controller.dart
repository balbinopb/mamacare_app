import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/data/services/bluetooth_services.dart';

class BluetoothController extends GetxController {
  // Reactive states
  final pairedDevices = <Map<String, dynamic>>[].obs;
  final availableDevices = <Map<String, String>>[].obs;
  final isConnecting = false.obs;

  static const platform = MethodChannel('channel/bluetooth');

  //Get paired devices
  Future<void> getPairedDevices() async {
    try {
      final devices = await platform.invokeMethod('getPairedDevices');
      pairedDevices.value = List<Map<String, dynamic>>.from(devices);
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal ambil perangkat: ${e.message}");
    }
  }

  //Scan for nearby devices
  Future<void> scanDevices() async {
    try {
      availableDevices.clear();
      final result = await BluetoothService.platform.invokeMethod(
        'scanDevices',
      );
      for (var device in result) {
        availableDevices.add({
          'name': device['name'],
          'address': device['address'],
        });
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal scan perangkat Bluetooth");
    }
  }

  //Connect to device
  Future<void> connectToDevice(String address) async {
    try {
      isConnecting.value = true;
      final result = await BluetoothService.connect(address);
      Get.snackbar("Bluetooth", result);
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal konek: ${e.message}");
    } finally {
      isConnecting.value = false;
    }
  }

  //Send data
  Future<void> sendData(Map<String,dynamic> data) async {
    try {
      await BluetoothService.sendData(data);
      Get.snackbar("Bluetooth", "Data terkirim");
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal kirim data: ${e.message}");
    }
  }

  //Disconnect
  Future<void> disconnect() async {
    try {
      await BluetoothService.disconnect();
      Get.snackbar("Bluetooth", "Terputus dari perangkat");
    } on PlatformException catch (e) {
      Get.snackbar("Error", "Gagal putuskan koneksi: ${e.message}");
    }
  }
}
