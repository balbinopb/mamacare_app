import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/general/indicator_card.dart';
import 'package:mamacare/app/widgets/general/map_rot_chart.dart';
import 'package:mamacare/app/widgets/general/pop_up_menu.dart';
import 'package:mamacare/app/widgets/general/risk_card.dart';
import 'package:mamacare/app/widgets/general/week_card.dart';
import '../controllers/bluetooth_controller.dart';
import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  const UserDetailsView({super.key});

  // Better error handling and user feedback
  Future<void> _onFabPressed(
    BuildContext context,
    BluetoothController bluetoothController,
    Map<String, dynamic> args,
  ) async {
    try {
      // Show loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await bluetoothController.scanDevices();

      // Close loading dialog
      Get.back();

      if (bluetoothController.availableDevices.isEmpty) {
        Get.snackbar(
          "Bluetooth",
          "No nearby devices found",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      _showDeviceSelectionBottomSheet(bluetoothController, args);
    } catch (e) {
      Get.back(); // Close loading dialog if open
      Get.snackbar(
        "Error",
        "Failed to scan devices: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Separated bottom sheet logic for better readability
  void _showDeviceSelectionBottomSheet(
    BluetoothController bluetoothController,
    Map<String, dynamic> args,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Bluetooth Device",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Better list handling with max height
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: bluetoothController.availableDevices.length,
                itemBuilder: (context, index) {
                  final device = bluetoothController.availableDevices[index];
                  return _buildDeviceListTile(
                    device,
                    bluetoothController,
                    args,
                  );
                },
              ),
            ),

            // Connection status indicator
            Obx(
              () => bluetoothController.isConnecting.value
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  // Extracted device tile for cleaner code
  Widget _buildDeviceListTile(
    Map<String, dynamic> device,
    BluetoothController bluetoothController,
    Map<String, dynamic> args,
  ) {
    return ListTile(
      leading: const Icon(Icons.bluetooth, color: Colors.blue),
      title: Text(device['name'] ?? 'Unknown Device'),
      subtitle: Text(device['address'] ?? 'No address'),
      onTap: () => _handleDeviceConnection(device, bluetoothController, args),
    );
  }

  // Better error handling for device connection
  Future<void> _handleDeviceConnection(
    Map<String, dynamic> device,
    BluetoothController bluetoothController,
    Map<String, dynamic> args,
  ) async {
    Get.back(); // Close bottom sheet

    try {
      final deviceAddress = device['address'];
      if (deviceAddress == null || deviceAddress.isEmpty) {
        throw Exception('Invalid device address');
      }

      await bluetoothController.connectToDevice(deviceAddress);

      // Null safety and validation
      final user = args['user'];
      if (user == null) {
        throw Exception('User data not found');
      }

      final double weight = (user.weight as num?)?.toDouble() ?? 0.0;
      final double height = (user.height as num?)?.toDouble() ?? 1.0;

      if (height == 0) {
        throw Exception('Invalid height value');
      }

      final double bmi = weight / (height * height);

      final dataToSend = {
        "userId": "${user.id}",
        "adminId": args['adminId'] ?? '',
        "userImt": bmi,
        "userAge": user.age ?? 0,
      };

      await bluetoothController.sendData(dataToSend);

      Get.snackbar(
        "Success",
        "Connected to ${device['name'] ?? 'device'}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Connection Failed",
        "Could not connect: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }

  // Extracted header widget
  Widget _buildHeader(dynamic user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            "assets/user.png",
            height: 54,
            width: 54,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 54,
                width: 54,
                color: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.grey),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hai, ${user?.name ?? 'User'}",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              Obx(
                () => Text(
                  controller.currentTime.value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Extracted week cards section
  Widget _buildWeekCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          8, // weeks 9-16
          (index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: WeekCard(week: index + 9),
          ),
        ),
      ),
    );
  }

  // Extracted indicators section
  Widget _buildIndicators() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IndicatorCard(
          icon: Icons.bloodtype,
          iconColor: Color(0xFFC73133),
          label: "MAP",
          value: "93",
          unit: "mmHg",
          status: "Hipertensi",
          backgroundColor: Color(0xFFFAEBEB),
        ),
        IndicatorCard(
          icon: Icons.rotate_right,
          iconColor: AppColors.yellow1,
          label: "ROT",
          value: "25",
          unit: "deg",
          status: "High",
          backgroundColor: Color(0xFFFFFAEA),
        ),
        IndicatorCard(
          icon: Icons.accessibility_new,
          iconColor: Color(0xFF539660),
          label: "BMI",
          value: "23,4",
          unit: "kg",
          status: "Normal",
          backgroundColor: Color(0xFFEEF5F0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get controller once and reuse
    final bluetoothC = Get.put(BluetoothController());

    // Null safety for arguments
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final user = args['user'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(user),
                const SizedBox(height: 24),
                _buildWeekCards(),
                const SizedBox(height: 24),
                Obx(() => RiskCard(data: controller.risk.value)),
                const SizedBox(height: 24),
                _buildIndicators(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Report",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const PopUpMenu(),
                  ],
                ),
                Obx(() => MapRotChart(data: controller.chartData.value)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: bluetoothC.isConnecting.value
              ? null // Disable when connecting
              : () => _onFabPressed(context, bluetoothC, args),
          child: Icon(
            bluetoothC.isConnecting.value
                ? Icons.bluetooth_disabled
                : Icons.bluetooth_searching,
            color: bluetoothC.isConnecting.value
                ? Colors.grey
                : Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
