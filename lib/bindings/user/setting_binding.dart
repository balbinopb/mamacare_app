
import 'package:get/get.dart';
import 'package:mamacare/controllers/user/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}