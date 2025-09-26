import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/routes/app_pages.dart';

class VerifyOtpController extends GetxController {
  final otpController = TextEditingController();
  final isLoading=false.obs;

  Future<void> verifyOtp({required String otp}) async {
    final verificationId = Get.arguments['verificationId'];
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.snackbar("Success", "Phone verified successfully!");
      Get.offAllNamed(Routes.ADMIN_NAV_BAR);
    } catch (e) {
      // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      Get.snackbar(
      "Oops!",
      "Verifikasi OTP gagal. Silakan coba lagi.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
