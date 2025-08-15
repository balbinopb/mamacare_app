
import 'package:get/get.dart';
import 'package:mamacare/views/user/history_screen.dart';
import 'package:mamacare/views/user/home_screen.dart';
import 'package:mamacare/views/user/setting_screen.dart';

class BottomController extends GetxController {
  final selectedIndex=0.obs;

  final screens=[
    HomeScreen(),
    HistoryScreen(),
    SettingScreen(),
  ];
  
}