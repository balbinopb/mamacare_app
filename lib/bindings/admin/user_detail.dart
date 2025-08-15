


import 'package:get/get.dart';
import 'package:mamacare/controllers/user/home_controller.dart';

class UserDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> HomeController());
  }
  
}