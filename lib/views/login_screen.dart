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
              LoginHeader(),
              Obx(
                () => CustomTextfield(
                  title: "Email",
                  placeholder: "Email",
                  controller: controller.emailController,
                  errorText: controller.emailError.value,
                ),
              ),
              Obx(
                () => CustomTextfield(
                  title: "Password",
                  placeholder: "Password",
                  isbscure: true,
                  controller: controller.passwordController,
                  errorText: controller.passwordError.value,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Forgot Password?",
                style: GoogleFonts.poppins(
                  color: Color(0xFFFBCC25),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
