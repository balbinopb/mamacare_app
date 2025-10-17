import 'package:get/get.dart';

import '../../../data/services/bluetooth_services.dart';

class BluetoothController extends GetxController {
  var devices = <Map<String, dynamic>>[].obs;
  var status = "Not connected".obs;
  var received = "".obs;
  var isConnected = false.obs;
  var isScanning = false.obs;
  var isConnecting = false.obs;

  @override
  void onInit() {
    super.onInit();
    BluetoothService.listen(
      onData: (msg) => received.value = msg,
      onLost: (err) {
        status.value = "Disconnected: $err";
        isConnected.value = false;
      },
    );
  }

  Future<void> scanDevices() async {
    try {
      isScanning.value = true;
      final list = await BluetoothService.getBondedDevices();
      devices.assignAll(list);
    } catch (e) {
      status.value = "Scan error: $e";
    } finally {
      isScanning.value = false;
    }
  }

  Future<void> connect(String address) async {
    try {
      isConnecting.value = true;
      final res = await BluetoothService.connect(address);
      status.value = res;
      isConnected.value = true;
    } catch (e) {
      status.value = "Connection failed: $e";
    } finally {
      isConnecting.value = false;
    }
  }

  Future<void> disconnect() async {
    await BluetoothService.disconnect();
    isConnected.value = false;
    status.value = "Disconnected";
  }
}
