import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamacare/logger_debug.dart';

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
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    husbandNameController.dispose();
    super.onClose();
  }
}
