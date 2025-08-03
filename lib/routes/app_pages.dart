import 'package:get/get.dart';
import 'package:mamacare/bindings/admin/admin_bottom_navbar_binding.dart';
import 'package:mamacare/bindings/user/about_binding.dart';
import 'package:mamacare/bindings/user/bottom_nav_binding.dart';
import 'package:mamacare/bindings/login_binding.dart';
import 'package:mamacare/bindings/user/profile_binding.dart';
import 'package:mamacare/bindings/user/setting_binding.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/views/admin/add_user_screen.dart';
import 'package:mamacare/views/admin/admin_about_screen.dart';
import 'package:mamacare/views/admin/admin_home_screen.dart';
import 'package:mamacare/views/admin/admin_setting_screen.dart';
import 'package:mamacare/views/login_screen.dart';
import 'package:mamacare/views/user/about_screen.dart';
import 'package:mamacare/views/user/profile_screen.dart';
import 'package:mamacare/views/user/reset_password_screen_screen.dart';
import 'package:mamacare/views/user/set_new_password_screen.dart';
import 'package:mamacare/views/user/setting_screen.dart';
import 'package:mamacare/widgets/admin/admin_bottom_navbar.dart';
import 'package:mamacare/widgets/user/bottom_navbar.dart';

class AppPages {
  static final routes = [
    // ----------USER ROUTES-----------

    // login
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),

    // reset pw
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
      binding: LoginBinding(),
    ),
    // set new pw
    GetPage(
      name: AppRoutes.setNewPassword,
      page: () => SetNewPasswordScreen(),
      binding: LoginBinding(),
    ),

    // user navbar
    GetPage(
      name: AppRoutes.userNavbar,
      page: () => BottomNavbar(),
      binding: BottomNavBinding(),
    ),

    GetPage(
      name: AppRoutes.userSettings,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),

    GetPage(
      name: AppRoutes.userProfile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.userAbout,
      page: () => AboutScreen(),
      binding: AboutBinding(),
    ),

    // ----------ADMIN ROUTES-----------
    GetPage(
      name: AppRoutes.adminNavbar,
      page: () => AdminBottomNavbar(),
      binding: AdminBottomNavbarBinding(),
    ),
    GetPage(
      name: AppRoutes.adminHome,
      page: () => AdminHomeScreen(),
      binding: AdminBottomNavbarBinding(),
    ),
    GetPage(
      name: AppRoutes.adminAdduser,
      page: () => AddUserScreen(),
      binding: AdminBottomNavbarBinding(),
    ),
    GetPage(
      name: AppRoutes.adminSettings,
      page: () => AdminSettingScreen(),
      binding: AdminBottomNavbarBinding(),
    ),
    GetPage(
      name: AppRoutes.adminAbout,
      page: () => AdminAboutScreen(),
      binding: AdminBottomNavbarBinding(),
    ),
  ];
}
