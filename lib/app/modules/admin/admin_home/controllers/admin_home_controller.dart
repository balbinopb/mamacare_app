import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamacare/app/data/models/user_model.dart';
import 'package:mamacare/app/routes/app_pages.dart';

class AdminHomeController extends GetxController {
  /// Search bar controller
  TextEditingController searchC = TextEditingController();

  /// Users list
  final users = <UserModel>[].obs;
  final searchUser = <UserModel>[].obs;

  /// Current time
  var currentTime = ''.obs;
  Timer? _timer;

  /// Firestore subscription
  StreamSubscription? _userSubscription;

  @override
  void onInit() {
    super.onInit();

    // Start clock
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());

    // Get current admin ID
    final adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId != null) {
      _userSubscription = FirebaseFirestore.instance
          .collection('sensorData')
          .doc(adminId)
          .collection('users')
          .snapshots()
          .listen((snapshot) {
            final fetchedUsers = snapshot.docs
                .map((doc) => UserModel.fromMap(doc.id, doc.data()))
                .toList();

            users.assignAll(fetchedUsers);
            searchUser.assignAll(fetchedUsers);
          });
    }
  }

  /// Update clock
  void _updateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a  dd MMMM yyyy').format(now);
  }

  /// Delete user by index from search list
  Future<void> deleteUser(int index) async {
    final adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId == null) return;

    final userToDelete = searchUser[index];

    await FirebaseFirestore.instance
        .collection('sensorData')
        .doc(adminId)
        .collection('users')
        .doc(userToDelete.id)
        .delete();

    // Remove locally to keep UI responsive
    users.removeWhere((u) => u.id == userToDelete.id);
    searchUser.removeAt(index);
  }

  /// Filter user by keyword
  void filterUser(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    if (lowerKeyword.isEmpty) {
      searchUser.assignAll(users);
    } else {
      searchUser.assignAll(
        users.where((user) => user.name.toLowerCase().contains(lowerKeyword)),
      );
    }
  }

  /// Fetch users once (not real-time)
  Future<void> getUsers() async {
    final adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('sensorData')
        .doc(adminId)
        .collection('users')
        .get();

    final fetchedUsers = snapshot.docs
        .map((doc) => UserModel.fromMap(doc.id, doc.data()))
        .toList();

    users.assignAll(fetchedUsers);
    searchUser.assignAll(fetchedUsers);
  }

  /// Navigate to details page
  void goToUserDetails(UserModel user) {
    // Get.toNamed(Routes.USER_DETAILS, arguments: user);
    final adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId != null) {
      Get.toNamed(
        Routes.USER_DETAILS,
        arguments: {'adminId': adminId, 'user': user},
      );
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _userSubscription?.cancel();
    searchC.dispose();
    super.onClose();
  }
}
