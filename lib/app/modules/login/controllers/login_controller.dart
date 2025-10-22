import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  // Error states
  final emailError = RxnString();
  final passwordError = RxnString();
  final phoneError = RxnString();

  // Loading states
  final isLoading = false.obs;
  final isOtpSending = false.obs;

  // Private fields
  String _verificationId = '';
  int? _resendToken;

  // Constants for better maintainability
  static const String _indonesiaCountryCode = '+62';
  static const Duration _refreshDelay = Duration(milliseconds: 500);
  static const Duration _otpTimeout = Duration(seconds: 60);

  // Better phone validation with regex
  bool _isValidPhoneNumber(String phone) {
    // Indonesian phone number: 8-13 digits after removing leading 0
    final phoneRegex = RegExp(r'^0?8[0-9]{8,11}$');
    return phoneRegex.hasMatch(phone);
  }

  // Separated phone formatting logic
  String _formatPhoneNumber(String phone) {
    String formatted = phone.trim();

    // Remove all spaces and special characters
    formatted = formatted.replaceAll(RegExp(r'[^0-9+]'), '');

    // If starts with 0, replace with +62
    if (formatted.startsWith('0')) {
      formatted = '$_indonesiaCountryCode${formatted.substring(1)}';
    }

    // If doesn't start with +, add +62
    if (!formatted.startsWith('+')) {
      formatted = '$_indonesiaCountryCode$formatted';
    }

    return formatted;
  }

  // Enhanced phone validation
  String? _validatePhone(String phone) {
    if (phone.isEmpty) {
      return "Phone number is required";
    }

    if (!_isValidPhoneNumber(phone)) {
      return "Please enter a valid Indonesian phone number";
    }

    return null;
  }

  // Enhanced email validation
  // void validateFormFields() {
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();

  //   emailError.value = email.isEmpty
  //       ? 'Email is required'
  //       : !GetUtils.isEmail(email)
  //       ? 'Please enter a valid email'
  //       : null;

  //   passwordError.value = password.isEmpty
  //       ? 'Password is required'
  //       : password.length < 6
  //       ? 'Password must be at least 6 characters'
  //       : null;
  // }

  // Better OTP sending with proper error handling and loading states
  Future<void> sendOtp() async {
    // Clear previous errors
    phoneError.value = null;

    final phone = phoneController.text.trim();

    // Validate phone number
    final validationError = _validatePhone(phone);
    if (validationError != null) {
      phoneError.value = validationError;
      return;
    }

    // Format phone number
    final formattedPhone = _formatPhoneNumber(phone);

    // Start loading
    isOtpSending.value = true;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: _otpTimeout,

        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await FirebaseAuth.instance.signInWithCredential(credential);
            isOtpSending.value = false;

            Get.snackbar(
              "Success",
              "Phone number automatically verified!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Get.theme.colorScheme.primary,
              colorText: Get.theme.colorScheme.onPrimary,
            );

            // Navigate to home or main page
            // Get.offAllNamed(Routes.HOME);
          } catch (e) {
            isOtpSending.value = false;
            _handleAuthError(e);
          }
        },

        verificationFailed: (FirebaseAuthException e) {
          isOtpSending.value = false;
          _handleFirebaseAuthException(e);
        },

        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          isOtpSending.value = false;

          Get.toNamed(
            Routes.VERIFY_OTP,
            arguments: {
              'verificationId': verificationId,
              'phoneNumber': formattedPhone,
              'resendToken': resendToken,
            },
          );
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      isOtpSending.value = false;
      _handleAuthError(e);
    }
  }

  // Dedicated error handling methods
  void _handleFirebaseAuthException(FirebaseAuthException e) {
    String errorMessage;

    switch (e.code) {
      case 'invalid-phone-number':
        errorMessage = 'The phone number format is invalid';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many attempts. Please try again later';
        break;
      case 'operation-not-allowed':
        errorMessage = 'Phone authentication is not enabled';
        break;
      case 'quota-exceeded':
        errorMessage = 'SMS quota exceeded. Please try again later';
        break;
      default:
        errorMessage = e.message ?? 'Verification failed. Please try again';
    }

    phoneError.value = errorMessage;

    Get.snackbar(
      "Error",
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 4),
    );
  }

  void _handleAuthError(dynamic e) {
    final errorMessage = e.toString().replaceAll('Exception: ', '');
    phoneError.value = errorMessage;

    Get.snackbar(
      "Error",
      "An error occurred: $errorMessage",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 4),
    );
  }

  // Add resend OTP functionality
  Future<void> resendOtp() async {
    if (_verificationId.isEmpty) {
      await sendOtp();
      return;
    }

    final phone = phoneController.text.trim();
    final formattedPhone = _formatPhoneNumber(phone);

    isOtpSending.value = true;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: _otpTimeout,
        forceResendingToken: _resendToken,
        verificationCompleted: (credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          isOtpSending.value = false;
        },
        verificationFailed: (e) {
          isOtpSending.value = false;
          _handleFirebaseAuthException(e);
        },
        codeSent: (verificationId, resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          isOtpSending.value = false;

          Get.snackbar(
            "Success",
            "OTP has been resent",
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      isOtpSending.value = false;
      _handleAuthError(e);
    }
  }

  // Enhanced refresh with proper state reset
  Future<void> onRefresh() async {
    await Future.delayed(_refreshDelay);

    // Clear all text fields
    // emailController.clear();
    // passwordController.clear();
    phoneController.clear();

    // Clear all errors
    emailError.value = null;
    passwordError.value = null;
    phoneError.value = null;

    // Reset loading states
    isLoading.value = false;
    isOtpSending.value = false;

    // Clear verification data
    _verificationId = '';
    _resendToken = null;
  }

  // Better cleanup
  @override
  void onClose() {
    // Dispose all text controllers
    // emailController.dispose();
    // passwordController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Add getter for formatted phone display
  String get formattedPhoneNumber {
    final phone = phoneController.text.trim();
    if (phone.isEmpty) return '';
    return _formatPhoneNumber(phone);
  }

  // Add method to check if form is valid
  bool get isPhoneValid {
    final phone = phoneController.text.trim();
    return _validatePhone(phone) == null;
  }
}
