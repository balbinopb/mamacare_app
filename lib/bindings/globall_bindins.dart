import 'package:get/get.dart';
import 'package:mamacare/controllers/bottom_controller.dart';

class GloballBindins extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomController());
  }
}
