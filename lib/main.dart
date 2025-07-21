import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mamacare/bindings/globall_bindins.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mamacare/widgets/bottom_navbar.dart';

void main()async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(milliseconds: 50));
  FlutterNativeSplash.remove(); 
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, 
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'mamacare',
      debugShowCheckedModeBanner: false,
      initialBinding: GloballBindins(),
      home: BottomNavbar(),
    );
  }
}
