import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/routes/app_pages.dart';

class AdminSettingController extends GetxController {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
