import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/data/models/user_model.dart';
import 'package:mamacare/app/widgets/general/indicator_card.dart';
import 'package:mamacare/app/widgets/general/map_rot_chart.dart';
import 'package:mamacare/app/widgets/general/pop_up_menu.dart';
import 'package:mamacare/app/widgets/general/risk_card.dart';
import 'package:mamacare/app/widgets/general/week_card.dart';
import 'package:mamacare/logger_debug.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  const UserDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    // Retrieve the argument
    final UserModel user = Get.arguments as UserModel;

    // Convert back to UserModel
    // final user = UserModel.fromMap(userMap['id'], userMap);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/user.png",
                        height: 54,
                        width: 54,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hai, ${user.name}",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
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
                  ],
                ),

                SizedBox(height: 24),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int week = 9; week < 17; week++)
                        Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: WeekCard(week: week),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                Obx(() => RiskCard(data: controller.risk.value)),

                SizedBox(height: 24),

                Row(
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
                ),

                SizedBox(height: 24),

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
                    PopUpMenu(),
                  ],
                ),

                Obx(() => MapRotChart(data: controller.chartData.value)),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Minta permission runtime sebelum akses Bluetooth
            final status = await Permission.bluetoothConnect.request();
            if (!status.isGranted) {
              Get.snackbar("Permission", "Bluetooth permission ditolak");
              return;
            }

            // Ambil daftar device yang sudah paired
            var devices = await controller.getPairedDevices();

            if (devices.isEmpty) {
              Get.snackbar("Info", "Tidak ada device yang sudah dipasangkan");
              return;
            }

            //  Tampilkan bottom sheet list device
            Get.bottomSheet(
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Pilih Device",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    ...devices.map(
                      (device) => ListTile(
                        title: Text(device.name ?? "Unknown"),
                        subtitle: Text(device.address),
                        onTap: () {
                          Get.back(); // Tutup bottom sheet
                          controller.connectAndSend(
                            device,
                          ); // Connect + kirim data
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } catch (e) {
            Get.snackbar("Error", "Terjadi error: $e");
            logger.d("error : $e");
          }
        },
        backgroundColor: AppColors.yellow1,
        child: Obx(
          () => controller.isConnecting.value
              ? CircularProgressIndicator(color: Colors.black)
              : Icon(Icons.send, color: Colors.black),
        ),
      ),
    );
  }
}
