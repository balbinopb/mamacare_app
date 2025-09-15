import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/admin/input_field.dart';
// import 'package:mamacare/logger_debug.dart';
import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
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
              onSurface: AppColors.black,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tambah Data",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tambahkan Data Ibu Hamil",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF82909C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: controller.saveUser,
                          icon: Icon(
                            Icons.check,
                            color: AppColors.yellow1,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // SizedBox(height: 20),
                // Center(
                //   child: Stack(
                //     children: [
                //       Obx(() {
                //         return CircleAvatar(
                //           radius: 50,
                //           backgroundImage: controller.pickedImage.value != null
                //               ? FileImage(controller.pickedImage.value!)
                //               : AssetImage('assets/user.png') as ImageProvider,
                //         );
                //       }),
                //       Positioned(
                //         bottom: 0,
                //         right: 0,
                //         child: InkWell(
                //           onTap: () {
                //             // logger.d("before pick image get called");
                //             controller.pickImage();
                //             // logger.d("after pick image get called");
                //           },
                //           borderRadius: BorderRadius.circular(16),
                //           child: CircleAvatar(
                //             backgroundColor: Colors.amber,
                //             radius: 16,
                //             child: Icon(
                //               Icons.edit,
                //               size: 16,
                //               color: AppColors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 30),
                InputField(
                  label: "Nama Ibu Hamil",
                  controller: controller.nameController,
                  hintText: 'Nama lengkap',
                ),
                InputField(
                  label: "No Hp",
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'No Hp',
                ),
                InputField(
                  label: "Tanggal Lahir Ibu Hamil",
                  controller: controller.dobController,
                  hintText: 'DD/MM/YYYY',
                  readOnly: true,
                  ontap: () => _pickDate(context, 'dob'),
                ),
                InputField(
                  label: "Usia Ibu Hamil",
                  controller: controller.ageController,
                  hintText: '23',
                ),
                InputField(
                  label: "Nama Suami",
                  controller: controller.husbandNameController,
                  hintText: "Nama Suami",
                ),
                InputField(
                  label: "Kehamilan ke",
                  controller: controller.pregnancyNumberController,
                  hintText: '2',
                ),

                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        label: "Keguguran",
                        controller: controller.miscarriageController,
                        hintText: '0',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InputField(
                        label: "Melahirkan",
                        controller: controller.childbirthController,
                        hintText: '2',
                      ),
                    ),
                  ],
                ),

                InputField(
                  label: "Hari Pertama Haid Terakhir",
                  controller: controller.firstDayOfLastPeriodController,
                  hintText: 'DD/MM/YYYY',
                  readOnly: true,
                  ontap: ()=> _pickDate(context,'firstDayOfLastPeriod'),
                ),
                InputField(
                  label: "Hari Perkiraan Lahir",
                  controller: controller.estimatedBirthDateController,
                  hintText: 'DD/MM/YYYY',
                  readOnly: true,
                  ontap: () => _pickDate(context, 'estimatedBirthDate'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        label: "Weight(Kg)",
                        controller: controller.weightController,
                        hintText: '55',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InputField(
                        label: "Height(Cm)",
                        controller: controller.heightController,
                        hintText: '165',
                      ),
                    ),
                  ],
                ),
                InputField(
                  label: "Lingkar Lengan Atas(cm)",
                  controller: controller.upperArmCircumferenceController,
                  hintText: '30',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
