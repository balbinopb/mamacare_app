import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/controllers/setting_controller.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/widgets/setting/info_card.dart';
import 'package:mamacare/widgets/setting/menu_tile.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Back button and title
              Row(
                children: [
                  const Icon(Icons.arrow_back, size: 24),
                  const SizedBox(width: 10),
                  const Text(
                    'Setting',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Profile avatar
              const CircleAvatar(
                radius: 65,
                backgroundColor: Color(0xFFFFB00B),
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
              ),
              const SizedBox(height: 10),

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
              const SizedBox(height: 30),

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
                      color: const Color(0xFFFAEBEB),
                      valueColor: Colors.red,
                    ),
                    InfoCard(
                      icon: Icons.monitor_weight,
                      label: 'Weight',
                      value: controller.weight.value.toString(),
                      unit: 'kg',
                      color: const Color(0xFFFFFAEA),
                      valueColor: const Color(0xFFFBCC25),
                    ),
                    InfoCard(
                      icon: Icons.height,
                      label: 'Height',
                      value: controller.height.value.toString(),
                      unit: 'cm',
                      color: const Color(0xFFEEF5F0),
                      valueColor: Colors.green,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Menu options
              MenuTile(
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  Get.toNamed(AppRoutes.profile);
                },
              ),
              MenuTile(
                icon: Icons.info,
                title: 'About',
                onTap: () => Get.toNamed(AppRoutes.about),
              ),
              MenuTile(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () => controller.logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
