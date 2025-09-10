import 'package:get/get.dart';

import '../modules/admin/add_user/bindings/add_user_binding.dart';
import '../modules/admin/add_user/views/add_user_view.dart';
import '../modules/admin/admin_about/bindings/admin_about_binding.dart';
import '../modules/admin/admin_about/views/admin_about_view.dart';
import '../modules/admin/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin/admin_home/views/admin_home_view.dart';
import '../modules/admin/admin_nav_bar/bindings/admin_nav_bar_binding.dart';
import '../modules/admin/admin_nav_bar/views/admin_nav_bar_view.dart';
import '../modules/admin/admin_setting/bindings/admin_setting_binding.dart';
import '../modules/admin/admin_setting/views/admin_setting_view.dart';
import '../modules/admin/edit_user/bindings/edit_user_binding.dart';
import '../modules/admin/edit_user/views/edit_user_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/user_details/bindings/user_details_binding.dart';
import '../modules/user_details/views/user_details_view.dart';
import '../modules/user_history/bindings/user_history_binding.dart';
import '../modules/user_history/views/user_history_view.dart';
import '../modules/admin/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/admin/verify_otp/views/verify_otp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => const AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_NAV_BAR,
      page: () => const AdminNavBarView(),
      binding: AdminNavBarBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_SETTING,
      page: () => const AdminSettingView(),
      binding: AdminSettingBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_ABOUT,
      page: () => const AdminAboutView(),
      binding: AdminAboutBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAILS,
      page: () => const UserDetailsView(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: _Paths.USER_HISTORY,
      page: () => const UserHistoryView(),
      binding: UserHistoryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_USER,
      page: () => const EditUserView(),
      binding: EditUserBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
  ];
}
