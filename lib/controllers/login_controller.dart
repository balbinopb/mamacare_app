import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var emailError = RxnString();
  var passwordError = RxnString();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void validateFormFields() {
    emailError.value = emailController.text.trim().isEmpty
        ? 'Email is required'
        : null;
    passwordError.value = passwordController.text.trim().isEmpty
        ? 'Password is required'
        : null;
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await checkRoleAndRedirect();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login failed");
    }
  }

  Future<void> checkRoleAndRedirect() async {
    try {
      String uid = _auth.currentUser!.uid;

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (!userDoc.exists) {
        Get.snackbar("Error", "User data not found in Firestore");
        return;
      }

      String role = userDoc['role'];

      if (role == 'admin') {
        Get.offAndToNamed(AppRoutes.adminNavbar);
      } else if (role == 'user') {
        Get.offAndToNamed(AppRoutes.userNavbar);
      } else {
        Get.snackbar("Error", "Unknown role: $role");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to get role: $e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
