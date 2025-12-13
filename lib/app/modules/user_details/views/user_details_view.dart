import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/general/indicator_card.dart';
import 'package:mamacare/app/widgets/general/map_rot_chart.dart';
import 'package:mamacare/app/widgets/general/pop_up_menu.dart';
import 'package:mamacare/app/widgets/general/risk_card.dart';
import '../controllers/bluetooth_controller.dart';
import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  // ignore: prefer_const_constructors_in_immutables
  UserDetailsView({super.key});

  // Global class fields
  late final Map<String, dynamic> args;
  late final dynamic user;

  @override
  Widget build(BuildContext context) {
    final bluetoothC = Get.put(BluetoothController());

    // Initialize arguments
    args = Get.arguments as Map<String, dynamic>? ?? {};
    user = args['user'];
    if (user == null) {
      throw Exception("User not found in arguments");
    }

    controller.listenToSensorData(args['adminId'], user.id);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildWeekCards(),
              const SizedBox(height: 24),
              Obx(() => RiskCard(data: controller.risk.value,args: args,)),
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
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: bluetoothC.isConnecting.value
              ? null
              : () => _onFabPressed(bluetoothC),
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

  // --- Bluetooth Logic ---
  Future<void> _onFabPressed(BluetoothController bluetoothController) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await bluetoothController.scanDevices();
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

      _showDeviceSelectionBottomSheet(bluetoothController);
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Failed to scan devices: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _showDeviceSelectionBottomSheet(
    BluetoothController bluetoothController,
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
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: bluetoothController.availableDevices.length,
                itemBuilder: (context, index) {
                  final device = bluetoothController.availableDevices[index];
                  return _buildDeviceListTile(device, bluetoothController);
                },
              ),
            ),
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

  Widget _buildDeviceListTile(
    Map<String, dynamic> device,
    BluetoothController bluetoothController,
  ) {
    return ListTile(
      leading: const Icon(Icons.bluetooth, color: Colors.blue),
      title: Text(device['name'] ?? 'Unknown Device'),
      subtitle: Text(device['address'] ?? 'No address'),
      onTap: () => _handleDeviceConnection(device, bluetoothController),
    );
  }

  Future<void> _handleDeviceConnection(
    Map<String, dynamic> device,
    BluetoothController bluetoothController,
  ) async {
    Get.back(); // Close bottom sheet
    try {
      final deviceAddress = device['address'];
      if (deviceAddress == null || deviceAddress.isEmpty) {
        throw Exception('Invalid device address');
      }

      await bluetoothController.connectToDevice(deviceAddress);

      // print("===========================${calculateIMT()}==============================");
      final dataToSend = {
        "userId": "${user.id}",
        "adminId": args['adminId'] ?? '',
        "userImt": calculateIMT(),
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

  // --- calculate IMT ---
  double calculateIMT() {
    final double weight = (user.weight as num?)?.toDouble() ?? 0.0;
    final double heightCm = (user.height as num?)?.toDouble() ?? 1.0;

    if (heightCm == 0) throw Exception('Invalid height value');

    final double heightM = heightCm / 100;
    return ((weight / (heightM * heightM)) * 10).ceil() /
        10; // 1 decimal, rounded up
  }

  // --- UI ---
  Widget _buildHeader() {
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

Widget _buildWeekCards() {
  return Obx(() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          8, // Week 9 - 16
          (index) {
            final weekNum = index + 9;
            final isSelected = controller.selectedWeek.value == weekNum;

            return GestureDetector(
              onTap: () => controller.selectWeek(weekNum),
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  height: 68,
                  width: 51,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.yellow1 : Colors.transparent,
                    border: Border.all(color: AppColors.yellow1, width: 2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: AppColors.yellow1.withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Week",
                        style: GoogleFonts.poppins(
                          color: isSelected ? AppColors.white : AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "$weekNum",
                        style: GoogleFonts.poppins(
                          color: isSelected ? AppColors.white : AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  });
}


  Widget _buildIndicators() {
    if (user == null) return const SizedBox();

    final userDataRef = FirebaseFirestore.instance
        .collection('sensorData')
        .doc(args['adminId'])
        .collection('users')
        .doc(user.id)
        .collection('readsensor');

    return StreamBuilder<QuerySnapshot>(
      stream: userDataRef
          .orderBy('createAt', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No sensor data yet'));
        }

        final latestDoc = snapshot.data!.docs.first;
        final data = latestDoc.data() as Map<String, dynamic>;

        // Weight & height
        final double weight = (user.weight as num?)?.toDouble() ?? 0.0;
        final double heightCm = (user.height as num?)?.toDouble() ?? 1.0;
        final double heightM = heightCm / 100;

        if (heightM == 0) return const Text('Invalid height data');

        // BMI rounded to 1 decimal
        final double bmi = ((weight / (heightM * heightM)) * 10).ceil() / 10;

        // MAP & ROT
        final map = (data['MAP_Supine'] as num?)?.toStringAsFixed(1) ?? '-';
        final rot = (data['MAP_ROT'] as num?)?.toStringAsFixed(1) ?? '-';

        // Status helpers
        String getMapStatus(double value) {
          if (value > 110) return "Hipertensi";
          if (value < 70) return "Low";
          return "Normal";
        }

        String getBmiStatus(double value) {
          if (value < 18.5) return "Underweight";
          if (value < 25) return "Normal";
          if (value < 30) return "Overweight";
          return "Obese";
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IndicatorCard(
              icon: Icons.bloodtype,
              iconColor: const Color(0xFFC73133),
              label: "MAP",
              value: map,
              unit: "mmHg",
              status: getMapStatus(double.tryParse(map) ?? 0),
              backgroundColor: const Color(0xFFFAEBEB),
            ),
            IndicatorCard(
              icon: Icons.rotate_right,
              iconColor: AppColors.yellow1,
              label: "ROT",
              value: rot,
              unit: "deg",
              status: "High",
              backgroundColor: const Color(0xFFFFFAEA),
            ),
            IndicatorCard(
              icon: Icons.accessibility_new,
              iconColor: const Color(0xFF539660),
              label: "BMI",
              value: bmi.toStringAsFixed(1),
              unit: "kg/m²",
              status: getBmiStatus(bmi),
              backgroundColor: const Color(0xFFEEF5F0),
            ),
          ],
        );
      },
    );
  }
}
