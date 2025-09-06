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
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            children: [
              LoginHeader(first: "Welcome to \nMamacare", second: "Please login to continue",),
              Obx(
                () => CustomTextfield(
                  title: "Nomor HP",
                  placeholder: "Number phone",
                  controller: controller.emailController,
                  errorText: controller.emailError.value,
                ),
              ),
              Obx(
                () => CustomTextfield(
                  title: "Password",
                  placeholder: "Password",
                  isPassword: true,
                  controller: controller.passwordController,
                  errorText: controller.passwordError.value,
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  // Get.toNamed(AppRoutes.resetPassword);
                },
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                    color: AppColors.yellow1,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: controller.login,
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
                    child: Text("Login", style: GoogleFonts.poppins(color: Colors.black)),
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
    );
  }
}
