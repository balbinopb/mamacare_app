

import 'package:flutter/services.dart';
import 'package:mamacare/logger_debug.dart';

class BluetoothService {

  static const platform = MethodChannel('com.example.mamacare/bluetooth');

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
  static Future<void> sendData(String message) async {
    try {
      await platform.invokeMethod('sendData', {'message': message});
    } on PlatformException catch (e) {
      logger.d("ERROR : $e");
    }
  }

  // Disconnect
  static Future<void> disconnect() async {
    await platform.invokeMethod('DISCONNECT');
  }
}