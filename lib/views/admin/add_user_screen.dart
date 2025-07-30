import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/controllers/admin/add_user_controller.dart';
import 'package:mamacare/widgets/admin/input_field.dart';

class AddUserScreen extends GetView<AddUserController> {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add User",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/user.png',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 16,
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                InputField(
                  label: "Name",
                  controller: controller.nameController,
                ),
                InputField(
                  label: "Email",
                  controller: controller.emailController,
                ),
                InputField(
                  label: "No Hp",
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                ),
                InputField(
                  label: "Date of Birth",
                  controller: controller.dobController,
                ),
                InputField(
                  label: "Husband’s name",
                  controller: controller.husbandNameController,
                ),
                InputField(
                  label: "First day of last period",
                  controller: controller.firstDayOfLastPeriodController,
                ),
                InputField(
                  label: "Weight(Kg)",
                  controller: controller.weightController,
                ),
                InputField(
                  label: "Height(Cm)",
                  controller: controller.heightController,
                ),
                InputField(
                  label: "HPL",
                  controller: controller.hplController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
