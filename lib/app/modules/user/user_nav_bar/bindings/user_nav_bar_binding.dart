import 'package:get/get.dart';
import 'package:mamacare/app/modules/user/user_home/controllers/user_home_controller.dart';
import 'package:mamacare/app/modules/user/user_setting/controllers/user_setting_controller.dart';
import 'package:mamacare/app/modules/user_history/controllers/user_history_controller.dart';

import '../controllers/user_nav_bar_controller.dart';

class UserNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserNavBarController>(
      () => UserNavBarController(),
    );
    Get.lazyPut<UserHomeController>(
      () => UserHomeController(),
    );
    Get.lazyPut<UserHistoryController>(
      () => UserHistoryController(),
    );
    Get.lazyPut<UserSettingController>(
      () => UserSettingController(),
    );
  }
}
