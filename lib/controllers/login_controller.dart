import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var emailError = RxnString();
  var passwordError = RxnString();

  void validateFormFields() {
    emailError.value = emailController.text.trim().isEmpty
        ? 'Email is required'
        : null;
    passwordError.value = passwordController.text.trim().isEmpty
        ? 'Password is required'
        : null;
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    validateFormFields();

    if (email.isEmpty || password.isEmpty) {      
      return;
    }

    Get.offNamed(AppRoutes.navbar);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
