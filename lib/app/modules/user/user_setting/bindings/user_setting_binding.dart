import 'package:get/get.dart';

import '../controllers/user_setting_controller.dart';

class UserSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSettingController>(
      () => UserSettingController(),
    );
  }
}
