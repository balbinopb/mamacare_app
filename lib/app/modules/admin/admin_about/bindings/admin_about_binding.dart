import 'package:get/get.dart';

import '../controllers/admin_about_controller.dart';

class AdminAboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAboutController>(
      () => AdminAboutController(),
    );
  }
}
