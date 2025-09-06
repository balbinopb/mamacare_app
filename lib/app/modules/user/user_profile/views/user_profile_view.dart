import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/modules/user/edit_name/views/edit_name_view.dart';
import 'package:mamacare/app/widgets/user/input_field.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  Future<void> _pickDate(BuildContext context, String field) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.amber,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.amber),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.updateDate(field, picked);
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 24),
                    onPressed: Get.back,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Avatar
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Email
              Obx(
                () => InputField(
                  label: "Email",
                  hintText: controller.email.value,
                ),
              ),

              // Wife Name
              Obx(
                () => InputField(
                  label: "Name",
                  hintText: controller.wifeName.value,
                  hasEditIcon: true,
                  onTap: () {
                    Get.to(
                      () => EditNameView(
                        title: "Name",
                        initialValue: controller.wifeName.value,
                        onSave: (value) =>
                            controller.updateName(who: "wife", name: value),
                      ),
                    );
                  },
                ),
              ),

              // DOB
              Obx(
                () => InputField(
                  label: "Date of Birth",
                  hintText: controller.dateOfBirth.value,
                  hasEditIcon: true,
                  onTap: () => _pickDate(context, "dob"),
                ),
              ),

              // Husband Name
              Obx(
                () => InputField(
                  label: "Husband's name",
                  hintText: controller.husbandName.value,
                  hasEditIcon: true,
                  onTap: () {
                    Get.to(
                      () => EditNameView(//why all this argument must be filled in app_pages.dart
                        title: "Husband's name",
                        initialValue: controller.husbandName.value,
                        onSave: (value) =>
                            controller.updateName(who: "husband", name: value),
                      ),
                    );
                  },
                ),
              ),

              // Last Period
              Obx(
                () => InputField(
                  label: "First Day of Last Period",
                  hintText: controller.lastPeriod.value,
                  hasEditIcon: true,
                  onTap: () => _pickDate(context, "lastPeriod"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
