import 'package:get/get.dart';
import 'package:mamacare/controllers/user/bottom_controller.dart';
import 'package:mamacare/controllers/user/history_controller.dart';
import 'package:mamacare/controllers/user/home_controller.dart';
import 'package:mamacare/controllers/user/setting_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => HistoryController());
  }
}
