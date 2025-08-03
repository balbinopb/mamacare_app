import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/controllers/login_controller.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/widgets/user/login/custom_textfield.dart';
import 'package:mamacare/widgets/user/login/login_header.dart';



// still use login controller
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

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
              LoginHeader(first: "Reset Password\nfor Your Account", second: "Please set your email adress"),
              Obx(
                () => CustomTextfield(
                  title: "Email",
                  placeholder: "Email",
                  // controller: controller.emailController,
                  errorText: controller.emailError.value,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (){
                      Get.toNamed(AppRoutes.setNewPassword);
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
                    child: Text(
                      "Send Reset Link to Email",
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
