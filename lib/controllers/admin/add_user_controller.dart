
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddUserController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final husbandNameController = TextEditingController();
  final firstDayOfLastPeriodController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final hplController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    husbandNameController.dispose();
    super.onClose();
  }
}
