
import 'package:get/get.dart';
import 'package:mamacare/controllers/admin/add_user_controller.dart';
import 'package:mamacare/controllers/admin/admin_about_controller.dart';
import 'package:mamacare/controllers/admin/admin_bottom_navbar_controller.dart';
import 'package:mamacare/controllers/admin/admin_home_controller.dart';
import 'package:mamacare/controllers/admin/admin_setting_controller.dart';

class AdminBottomNavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>AdminBottomNavbarController());
    Get.lazyPut(()=>AdminHomeController());
    Get.lazyPut(()=>AddUserController());
    Get.lazyPut(() => AdminSettingController());
    Get.lazyPut(() => AdminAboutController());
  }
  
}