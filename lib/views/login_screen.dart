import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/controllers/login_controller.dart';
import 'package:mamacare/widgets/login/custom_textfield.dart';
import 'package:mamacare/widgets/login/login_header.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
              const LoginHeader(),
              CustomTextfield(
                title: "Email",
                placeholder: "Email",
                controller: controller.emailController,
              ),
              CustomTextfield(
                title: "Password",
                placeholder: "Password",
                isbscure: true,
                controller: controller.passwordController,
              ),
              const SizedBox(height: 30),
              Text(
                "Forgot Password?",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFBCC25),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
                    onPressed: controller.login,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFBCC25),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
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
