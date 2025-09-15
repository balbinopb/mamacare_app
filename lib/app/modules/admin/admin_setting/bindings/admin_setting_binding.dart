import 'package:get/get.dart';
import 'package:mamacare/app/modules/login/controllers/login_controller.dart';

import '../controllers/admin_setting_controller.dart';

class AdminSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSettingController>(
      () => AdminSettingController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
