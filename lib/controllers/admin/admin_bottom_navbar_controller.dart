import 'package:get/get.dart';
import 'package:mamacare/views/admin/add_user_screen.dart';
import 'package:mamacare/views/admin/admin_home_screen.dart';
import 'package:mamacare/views/admin/admin_setting_screen.dart';

class AdminBottomNavbarController extends GetxController {
  final selectedIndex = 0.obs;

  late final List screens;
  @override
  void onInit() {
    super.onInit();
    screens = [
      AdminHomeScreen(), 
      AddUserScreen(), 
      AdminSettingScreen()
      ];
  }
}
