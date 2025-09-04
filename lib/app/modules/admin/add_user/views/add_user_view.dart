import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/admin/input_field.dart';
import 'package:mamacare/logger_debug.dart';
import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  const AddUserView({super.key});
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
                SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Obx(() {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.pickedImage.value != null
                              ? FileImage(controller.pickedImage.value!)
                              : AssetImage('assets/user.png') as ImageProvider,
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            logger.d("before pick image get called");
                            controller.pickImage();
                            logger.d("after pick image get called");
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 16,
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),
                InputField(
                  label: "Name",
                  controller: controller.nameController,
                  hintText: 'Full name',
                ),
                InputField(
                  label: "Email",
                  controller: controller.emailController,
                  hintText: 'Email',
                ),
                InputField(
                  label: "No Hp",
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'No Hp',
                ),
                InputField(
                  label: "Date of Birth",
                  controller: controller.dobController,
                  hintText: 'DD/MM/YYYY',
                ),
                InputField(
                  label: "Husband’s name",
                  controller: controller.husbandNameController,
                  hintText: "Husband's full name",
                ),
                InputField(
                  label: "First day of last period",
                  controller: controller.firstDayOfLastPeriodController,
                  hintText: 'DD/MM/YYYY',
                ),
                InputField(
                  label: "Weight(Kg)",
                  controller: controller.weightController,
                  hintText: '55',
                ),
                InputField(
                  label: "Height(Cm)",
                  controller: controller.heightController,
                  hintText: '165',
                ),
                InputField(
                  label: "HPL",
                  controller: controller.hplController,
                  hintText: 'DD/MM/YYYY',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
