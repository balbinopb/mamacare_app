import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/controllers/admin/admin_setting_controller.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/widgets/user/menu_tile.dart';

class AdminSettingScreen extends GetView<AdminSettingController> {
  const AdminSettingScreen({super.key});

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
              Container(
                width: 152,
                height: 152,
                decoration: BoxDecoration(
                  color: Color(0xFFFFB10B),
                  shape: BoxShape.circle,
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.1416),
                  child: Image.asset(
                    'assets/pregnant.png',
                    width: 118,
                    height: 118,

                    // color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Name and age
              Text(
                "Admin mamacare",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 24),

              // Menu options
              MenuTile(
                icon: Icons.info,
                title: 'About',
                onTap: () => Get.toNamed(AppRoutes.adminAbout),
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
