import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/controllers/login_controller.dart';
import 'package:mamacare/widgets/user/login/custom_textfield.dart';
import 'package:mamacare/widgets/user/login/login_header.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});

  final LoginController controller = Get.put(LoginController());

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
              LoginHeader(
                first: "Set a  New Password\nfor Your Account",
                second: "Please login to continue",
              ),
              Obx(
                () => CustomTextfield(
                  title: "Password",
                  placeholder: "Enter your password",
                  isPassword: true,
                  // controller: controller.passwordController,
                  errorText: controller.passwordError.value,
                ),
              ),
              CustomTextfield(
                title: "Password Confirmation",
                placeholder: "Enter your password confirmation",
                isPassword: true,
                // controller: controller.passwordController,
                errorText: controller.passwordError.value,
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: controller.login,
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
                    child: Text(
                      "Save",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
