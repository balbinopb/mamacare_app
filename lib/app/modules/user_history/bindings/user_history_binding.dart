import 'package:get/get.dart';

import '../controllers/user_history_controller.dart';

class UserHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserHistoryController>(
      () => UserHistoryController(),
    );
  }
}
