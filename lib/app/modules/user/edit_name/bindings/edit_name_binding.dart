import 'package:get/get.dart';

import '../controllers/edit_name_controller.dart';

class EditNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditNameController>(
      () => EditNameController(),
    );
  }
}
