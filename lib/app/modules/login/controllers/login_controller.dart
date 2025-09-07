import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/routes/app_pages.dart';
import 'package:mamacare/logger_debug.dart';

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
    logger.t("trace login");
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    validateFormFields();

    if (email.isEmpty || password.isEmpty) {      
      return;
    }
    if(email=="admin"){
      Get.offNamed(Routes.ADMIN_NAV_BAR);

    }else{
      Get.offNamed(Routes.USER_NAV_BAR);
    }
    
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    emailController.clear();
    passwordController.clear();
    emailError.value = null;
    passwordError.value = null;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}
