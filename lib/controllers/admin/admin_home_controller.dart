

import 'package:get/get.dart';
import 'package:mamacare/models/admin/user_model.dart';

class AdminHomeController extends GetxController {

  var users = <UserModel>[].obs;

  @override
  void onInit() {
  
    super.onInit();

    // user mock
    users.assignAll(List.generate(100, (index) => UserModel(
      name: 'Stefanyy Martin${index+1}',
      email: 'stefanyy@gmail.com',
    )));
  }

  void deleteUser(int index) {
    users.removeAt(index);
  }

  int get userCount => users.length;
  
}