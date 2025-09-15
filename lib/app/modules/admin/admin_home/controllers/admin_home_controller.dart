import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/data/models/user_model/user_model.dart';
import 'package:mamacare/app/demo_data/mock_user_data.dart';
import 'package:intl/intl.dart';

class AdminHomeController extends GetxController {
  TextEditingController searchC = TextEditingController();
  final demoUsers = <UserModel>[].obs;
  final searchUser = <UserModel>[].obs;

  var currentTime = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    // live time
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());

    // load mock dat
    demoUsers.assignAll(
      List.generate(
        mockUserData.length,
        (index) => UserModel(
          name: mockUserData[index]['name']!,
          email: mockUserData[index]['email']!,
        ),
      ),
    );

    // show all default
    searchUser.assignAll(demoUsers);
  }

  void _updateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a  dd MMMM yyyy').format(now);
  }

  int get userCount => demoUsers.length;

  void deleteUser(int index) {
    final userToDelete = searchUser[index];
    demoUsers.remove(userToDelete);
    filteUser(searchC.text); // refresh filtered list
  }

  void filteUser(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    if (lowerKeyword.isEmpty) {
      searchUser.assignAll(demoUsers);
    } else {
      searchUser.assignAll(
        demoUsers.where(
          (user) => user.name.toLowerCase().contains(lowerKeyword),
        ),
      );
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
