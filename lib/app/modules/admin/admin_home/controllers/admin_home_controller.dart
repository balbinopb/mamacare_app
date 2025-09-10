import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mamacare/app/data/models/user_model/user_model.dart';
import 'package:mamacare/logger_debug.dart';

class AdminHomeController extends GetxController {
  TextEditingController searchC = TextEditingController();
  final users = <UserModel>[].obs;
  final searchUser = <UserModel>[].obs;

  var currentTime = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    // live time
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());

    // get current admin id
    final adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId != null) {
      FirebaseFirestore.instance
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

  void _updateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm a  dd MMMM yyyy').format(now);
  }

  int get userCount => users.length;

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
  }

  void filterUser(String keyword) {
    logger.d("Value $keyword");
    final lowerKeyword = keyword.toLowerCase();
    if (lowerKeyword.isEmpty) {
      searchUser.assignAll(users);
    } else {
      searchUser.assignAll(
        users.where((user) => user.name.toLowerCase().contains(lowerKeyword)),
      );
    }
  }


  Future<void> getUsers() async {
    //pull to refresh
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


  @override
  void onClose() {
    _timer?.cancel();
    searchC.dispose();
    super.onClose();
  }
}
