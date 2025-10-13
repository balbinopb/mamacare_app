import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/general/indicator_card.dart';
import 'package:mamacare/app/widgets/general/map_rot_chart.dart';
import 'package:mamacare/app/widgets/general/pop_up_menu.dart';
import 'package:mamacare/app/widgets/general/risk_card.dart';
import 'package:mamacare/app/widgets/general/week_card.dart';
import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  const UserDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    // get arguments
    final args = Get.arguments as Map<String, dynamic>;
    final user = args['user'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/user.png",
                        height: 54,
                        width: 54,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hai, ${user.name}",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4),
                          Obx(
                            () => Text(
                              controller.currentTime.value,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int week = 9; week < 17; week++)
                        Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: WeekCard(week: week),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                Obx(() => RiskCard(data: controller.risk.value)),

                SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IndicatorCard(
                      icon: Icons.bloodtype,
                      iconColor: Color(0xFFC73133),
                      label: "MAP",
                      value: "93",
                      unit: "mmHg",
                      status: "Hipertensi",
                      backgroundColor: Color(0xFFFAEBEB),
                    ),
                    IndicatorCard(
                      icon: Icons.rotate_right,
                      iconColor: AppColors.yellow1,
                      label: "ROT",
                      value: "25",
                      unit: "deg",
                      status: "High",
                      backgroundColor: Color(0xFFFFFAEA),
                    ),
                    IndicatorCard(
                      icon: Icons.accessibility_new,
                      iconColor: Color(0xFF539660),
                      label: "BMI",
                      value: "23,4",
                      unit: "kg",
                      status: "Normal",
                      backgroundColor: Color(0xFFEEF5F0),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Report",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    PopUpMenu(),
                  ],
                ),

                Obx(() => MapRotChart(data: controller.chartData.value)),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // logger.d("check ${user.id}");
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
