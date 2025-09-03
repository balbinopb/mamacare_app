import 'package:get/get.dart';
import 'package:mamacare/app/modules/admin/add_user/views/add_user_view.dart';
import 'package:mamacare/app/modules/admin/admin_home/views/admin_home_view.dart';
import 'package:mamacare/app/modules/admin/admin_setting/views/admin_setting_view.dart';

class AdminNavBarController extends GetxController {
  final selectedIndex = 0.obs;

  late final List screens;
  
  @override
  void onInit() {
    super.onInit();
    screens = [
      AdminHomeView(), 
      AddUserView(), 
      AdminSettingView()
    ];
  }
}
