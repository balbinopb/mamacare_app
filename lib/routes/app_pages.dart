import 'package:get/get.dart';
import 'package:mamacare/bindings/bottom_nav_binding.dart';
import 'package:mamacare/bindings/login_binding.dart';
import 'package:mamacare/routes/app_routes.dart';
import 'package:mamacare/views/login_screen.dart';
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
  ];
}
