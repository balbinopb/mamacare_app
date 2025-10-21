

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BluetoothService {

  static const platform = MethodChannel('channel/bluetooth');

  // Connect to a Bluetooth device
  static Future<String> connect(String address) async {
    try {
      final result = await platform.invokeMethod('connect', {'address': address});
      return result;
    } on PlatformException catch (e) {
      return 'FAILED: ${e.message}';
    }
  }

  // Send data to device
  static Future<void> sendData(Map<String,dynamic> data) async {
    try {
      await platform.invokeMethod('sendData', {'message': data});
    } on PlatformException catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  // Disconnect
  static Future<void> disconnect() async {
    await platform.invokeMethod('DISCONNECT');
  }
}