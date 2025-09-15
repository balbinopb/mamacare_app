import 'package:get/get.dart';
import 'package:mamacare/app/modules/admin/add_user/controllers/add_user_controller.dart';
import 'package:mamacare/app/modules/admin/admin_home/controllers/admin_home_controller.dart';
import 'package:mamacare/app/modules/admin/admin_nav_bar/controllers/admin_nav_bar_controller.dart';
import 'package:mamacare/app/modules/admin/admin_setting/controllers/admin_setting_controller.dart';

class AdminNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminNavBarController>(() => AdminNavBarController());
    Get.lazyPut<AdminHomeController>(() => AdminHomeController());
    Get.lazyPut<AddUserController>(() => AddUserController());
    Get.lazyPut<AdminSettingController>(() => AdminSettingController());
  }
}
