import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/controllers/user/setting_controller.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/widgets/user/setting/info_card.dart';
import 'package:mamacare/widgets/user/menu_tile.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Back button and title
              Row(
                children: [
                  // Icon(Icons.arrow_back, size: 24),
                  // SizedBox(width: 10),
                  Text(
                    'Setting',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Profile avatar
              CircleAvatar(
                radius: 65,
                backgroundColor: Color(0xFFFFB00B),
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
              ),
              SizedBox(height: 10),

              // Name and age (reactive)
              Obx(
                () => Text(
                  controller.name.value,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  '${controller.age.value} years old',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
              ),
              SizedBox(height: 30),

              // Info cards (trimester, weight, height)
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoCard(
                      icon: Icons.local_fire_department,
                      label: 'Trimester',
                      value: controller.trimester.value.toString(),
                      unit: 'week',
                      color: Color(0xFFFAEBEB),
                      valueColor: Colors.red,
                    ),
                    InfoCard(
                      icon: Icons.monitor_weight,
                      label: 'Weight',
                      value: controller.weight.value.toString(),
                      unit: 'kg',
                      color: Color(0xFFFFFAEA),
                      valueColor: Color(0xFFFBCC25),
                    ),
                    InfoCard(
                      icon: Icons.height,
                      label: 'Height',
                      value: controller.height.value.toString(),
                      unit: 'cm',
                      color: Color(0xFFEEF5F0),
                      valueColor: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Menu options
              MenuTile(
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  Get.toNamed(AppRoutes.userProfile);
                },
              ),
              MenuTile(
                icon: Icons.info,
                title: 'About',
                onTap: () => Get.toNamed(AppRoutes.userAbout),
              ),
              MenuTile(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.all(24),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 48,
                            color: Color(0xFFFBCC25),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Logout Confirmation",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12),
                          Text(
                            "You will be logged out of this account.Continue logging out?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Color(0xFFFBCC25)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  controller.logout();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Color(0xFFFBCC25)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
