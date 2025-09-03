import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_about_controller.dart';

class AdminAboutView extends GetView<AdminAboutController> {
  const AdminAboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminAboutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminAboutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
