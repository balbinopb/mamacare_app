import 'package:get/get.dart';
import 'package:mamacare/controllers/bottom_controller.dart';
import 'package:mamacare/controllers/home_controller.dart';
import 'package:mamacare/controllers/profile_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProfileController());
  }
}
