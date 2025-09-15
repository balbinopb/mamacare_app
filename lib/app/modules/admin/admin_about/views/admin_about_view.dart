import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/constants/app_constant.dart';

import '../controllers/admin_about_controller.dart';

class AdminAboutView extends GetView<AdminAboutController> {
  const AdminAboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: BackButton(color: AppColors.black),
          onPressed: Get.back,
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'About ${AppConstants.appName}',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset('assets/images/logo3.png', height: 120),
            SizedBox(height: 16),
            Text(
              AppConstants.appName,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF041560),
              ),
            ),
            SizedBox(height: 16),
            Text(
              AppConstants.description,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(fontSize: 13, color: AppColors.black),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.whatsapp,
                  size: 20,
                  color: Color(0xFF3C4550),
                ),
                SizedBox(width: 8),
                Text(
                  AppConstants.contactNumber,
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
