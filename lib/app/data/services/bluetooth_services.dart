import 'package:flutter/services.dart';

class BluetoothService {
  static const MethodChannel _channel = MethodChannel('bluetooth_channel');

  static Future<List<Map<String, dynamic>>> getBondedDevices() async {
    final List devices = await _channel.invokeMethod('getBondedDevices');
    return devices.map((d) => Map<String, dynamic>.from(d)).toList();
  }

  static Future<String> connect(String address) async {
    return await _channel.invokeMethod('connect', {'address': address});
  }

  static Future<bool> sendData(String data) async {
    return await _channel.invokeMethod('sendData', {'data': data});
  }

  static Future<void> disconnect() async {
    await _channel.invokeMethod('disconnect');
  }

  static void listen({
    required Function(String) onData,
    required Function(String) onLost,
  }) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onDataReceived') {
        onData(call.arguments);
      } else if (call.method == 'onConnectionLost') {
        onLost(call.arguments);
      }
    });
  }
}
