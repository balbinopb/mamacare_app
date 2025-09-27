import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/controllers/login_controller.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/widgets/user/login/custom_textfield.dart';
import 'package:mamacare/widgets/user/login/login_header.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  void _showRegisterDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/icons/register_popup_icon.png"),
            Text(
              "Register",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "To register, please visit the Mamacare\nclinic in person. Registration can only be done on-site.",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(fontSize: 13),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Color(0xFFFBCC25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              // =======HEADER ===============
              LoginHeader(
                first: "Welcome to \nMamacare",
                second: "Please login to continue",
              ),

              // =========NUMBER PHONE================
              Obx(
                () => CustomTextfield(
                  title: "Nomor HP",
                  placeholder: "Number phone",
                  controller: controller.emailController,
                  errorText: controller.emailError.value,
                ),
              ),

              // =========PASSWORD================
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

              // =========FORGOT PASSWORD================
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.resetPassword);
                },
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                    color: Color(0xFFFBCC25),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // =========LOGIN BUTTON================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      controller.login(
                        controller.emailController.text.trim(),
                        controller.passwordController.text.trim(),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFFFBCC25),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text("Login", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),

              // =========REGISTER================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () => _showRegisterDialog(context),
                    child: Text(
                      ' Register',
                      style: GoogleFonts.poppins(
                        color: Color(0xFFFBCC25),
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
