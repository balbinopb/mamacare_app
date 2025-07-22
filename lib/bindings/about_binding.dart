import 'package:get/get.dart';
import 'package:mamacare/controllers/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutController());
  }
}
