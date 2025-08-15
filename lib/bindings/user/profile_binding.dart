import 'package:get/get.dart';
import 'package:mamacare/controllers/user/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
