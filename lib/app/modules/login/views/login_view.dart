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
    // Cache text styles to avoid rebuilding GoogleFonts
    final buttonTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    final bodyTextStyle = GoogleFonts.poppins(fontSize: 14);
    final linkTextStyle = GoogleFonts.poppins(
      color: AppColors.yellow1,
      fontSize: 14,
    );

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.onRefresh,
          color: AppColors.yellow1,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              children: [
                const LoginHeader(
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
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 6,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: controller.sendOtp,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.yellow1,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: buttonTextStyle,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text("Send OTP", style: buttonTextStyle),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: bodyTextStyle),
                    TextButton(
                      onPressed: () {},
                      child: Text(' Register', style: linkTextStyle),
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
