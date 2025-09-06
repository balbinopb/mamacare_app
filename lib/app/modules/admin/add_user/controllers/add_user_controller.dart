import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamacare/logger_debug.dart';

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

    logger.d("trace pick image after inizialized ");
    if (image != null) {
      pickedImage.value = File(image.path);
    }
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
