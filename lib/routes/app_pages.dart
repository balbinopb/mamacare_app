import 'package:get/get.dart';
import 'package:mamacare/bindings/about_binding.dart';
import 'package:mamacare/bindings/bottom_nav_binding.dart';
import 'package:mamacare/bindings/login_binding.dart';
import 'package:mamacare/bindings/profile_binding.dart';
import 'package:mamacare/bindings/setting_binding.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/views/login_screen.dart';
import 'package:mamacare/views/user/about_screen.dart';
import 'package:mamacare/views/user/profile_screen.dart';
import 'package:mamacare/views/user/setting_screen.dart';
import 'package:mamacare/widgets/bottom_navbar.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.navbar,
      page: () => BottomNavbar(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => AboutScreen(),
      binding: AboutBinding(),
    ),
  ];
}
