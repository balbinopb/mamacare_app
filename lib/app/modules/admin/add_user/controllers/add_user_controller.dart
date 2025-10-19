import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddUserController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final husbandNameController = TextEditingController();
  final pregnancyNumberController = TextEditingController();
  final miscarriageController = TextEditingController();
  final childbirthController = TextEditingController();
  final firstDayOfLastPeriodController = TextEditingController();
  final estimatedBirthDateController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final upperArmCircumferenceController = TextEditingController();

  var pickedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> saveUser() async {
    try {
      // Get current logged-in admin UID
      final adminId = FirebaseAuth.instance.currentUser?.uid;
      if (adminId == null) {
        throw Exception("Admin not logged in");
      }

      // Create a new user document inside admin's users subcollection
      final userDoc = FirebaseFirestore.instance
          .collection("sensorData")
          .doc(adminId)
          .collection("users")
          .doc(); // auto-ID for user

      await userDoc.set({
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "date_of_birth": dobController.text.trim(),
        "age": int.tryParse(ageController.text.trim()) ?? 0,
        "husbandName": husbandNameController.text.trim(),
        "pregnancy_number":
            int.tryParse(pregnancyNumberController.text.trim()) ?? 0,
        "miscarriage": int.tryParse(miscarriageController.text.trim()) ?? 0,
        "childbirth": int.tryParse(childbirthController.text.trim()) ?? 0,
        "firstDayOfLastPeriod": firstDayOfLastPeriodController.text.trim(),
        "estimatedBirthDate": estimatedBirthDateController.text.trim(),
        "weight": double.tryParse(weightController.text.trim()) ?? 0.0,
        "height": double.tryParse(heightController.text.trim()) ?? 0.0,
        "upperArmCircumference": double.tryParse(upperArmCircumferenceController.text.trim()) ?? 0.0,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "User info added successfully!");
      clearFields();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void updateDate(String field, DateTime date) {
    final formattedDate =
        "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";

    switch (field) {
      case 'dob':
        dobController.text = formattedDate;
        break;
      case 'firstDayOfLastPeriod':
        firstDayOfLastPeriodController.text = formattedDate;
        break;
      case 'estimatedBirthDate':
        estimatedBirthDateController.text = formattedDate;
        break;
    }
  }

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    dobController.clear();
    ageController.clear();
    husbandNameController.clear();
    pregnancyNumberController.clear();
    miscarriageController.clear();
    childbirthController.clear();
    firstDayOfLastPeriodController.clear();
    estimatedBirthDateController.clear();
    weightController.clear();
    heightController.clear();
    upperArmCircumferenceController.clear();
    pickedImage.value = null;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    ageController.dispose();
    husbandNameController.dispose();
    pregnancyNumberController.dispose();
    miscarriageController.dispose();
    childbirthController.dispose();
    firstDayOfLastPeriodController.dispose();
    estimatedBirthDateController.dispose();
    weightController.dispose();
    heightController.dispose();
    upperArmCircumferenceController.dispose();
    super.onClose();
  }
}
