import 'package:get/get.dart';
import 'package:mamacare/app/modules/user/user_home/views/user_home_view.dart';
import 'package:mamacare/app/modules/user/user_setting/views/user_setting_view.dart';
import 'package:mamacare/app/modules/user_history/views/user_history_view.dart';

class UserNavBarController extends GetxController {
  final selectedIndex = 0.obs;

  late final List screens;
  
  @override
  void onInit() {
    super.onInit();
    screens = [
      UserHomeView(), 
      UserHistoryView(), 
      UserSettingView()
    ];
  }
}
