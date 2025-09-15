import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/routes/app_pages.dart';
import 'package:mamacare/logger_debug.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var emailError = RxnString();
  var passwordError = RxnString();

  final phoneController = TextEditingController();
  final phoneError = ''.obs;

  // ignore: unused_field
  String _verificationId = '';

  void validateFormFields() {
    emailError.value = emailController.text.trim().isEmpty
        ? 'Email is required'
        : null;
    passwordError.value = passwordController.text.trim().isEmpty
        ? 'Password is required'
        : null;
  }

  Future<void> sendOtp() async {
    String phone = phoneController.text.trim();

    logger.d(" get $phone");

    if (phone.isEmpty) {
      phoneError.value = "Phone number is required";
      return;
    }

    if (phone.startsWith('0')) {
      phone = '+62${phone.substring(1)}';
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Get.snackbar("Success", "Phone number automatically verified!");
        },
        verificationFailed: (FirebaseAuthException e) {
          phoneError.value = e.message ?? "Verification failed";
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          Get.toNamed(
            Routes.VERIFY_OTP,
            arguments: {'verificationId': verificationId},
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      phoneError.value = e.toString();
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
