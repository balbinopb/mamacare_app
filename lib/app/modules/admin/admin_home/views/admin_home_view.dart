import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/admin/user_tile.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: controller.getUsers,
            color: AppColors.yellow1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========Header==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hai Admin',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Obx(
                          () => Text(
                            controller.currentTime.value,
                            style: GoogleFonts.poppins(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.notifications,
                      size: 40,
                      color: AppColors.yellow1,
                    ),
                  ],
                ),

                // =======Header========
                SizedBox(height: 16),

                // =============Search bar===========
                TextField(
                  controller: controller.searchC,
                  onChanged: controller.filterUser,
                  decoration: InputDecoration(
                    hintText: 'Search user ...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.tune, color: AppColors.yellow1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.yellow1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.yellow1,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                // ==========Search bar==========
                SizedBox(height: 16),

                // ===========User count card ===========
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFC107), Color(0xFFFFA000)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.shade200,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),

                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Users',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Obx(
                              () => Text(
                                '${controller.users.length}',
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Image.asset("assets/pregnant.png", height: 100),
                      SizedBox(width: 70),
                    ],
                  ),
                ),

                // ==========User Count card============
                SizedBox(height: 16),

                // ============== User list ================
                Text(
                  'User List',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      itemCount: controller.searchUser.length,
                      itemBuilder: (context, index) {
                        final user = controller.searchUser[index];
                        return UserTile(
                          onNavigateToUserDetails: () =>
                              controller.goToUserDetails(user),
                          user: user,
                          onDeleteUser: () => controller.deleteUser(index),
                        );
                      },
                    ),
                  ),
                ),

                // =========userlist=============
              ],
            ),
          ),
        ),
      ),
    );
  }
}
