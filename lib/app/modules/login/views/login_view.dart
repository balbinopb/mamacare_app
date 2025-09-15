import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/general/custom_textfield.dart';
import 'package:mamacare/app/widgets/general/login_header.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.onRefresh,
          color: AppColors.yellow1,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              children: [
                LoginHeader(
                  first: "Welcome to \nMamacare",
                  second: "Please login to continue",
                ),
                Obx(
                  () => CustomTextfield(
                    title: "Nomor HP",
                    placeholder: "Phone number",
                    controller: controller.phoneController,
                    errorText: controller.phoneError.value,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: controller.sendOtp,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.yellow1,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        "Send OTP",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        ' Register',
                        style: GoogleFonts.poppins(
                          color: AppColors.yellow1,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
