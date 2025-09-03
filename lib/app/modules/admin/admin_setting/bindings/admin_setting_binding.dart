import 'package:get/get.dart';

import '../controllers/admin_setting_controller.dart';

class AdminSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSettingController>(
      () => AdminSettingController(),
    );
  }
}
