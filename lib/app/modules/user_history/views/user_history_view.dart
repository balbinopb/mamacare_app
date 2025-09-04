import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/general/map_rot_chart.dart';
import 'package:mamacare/app/widgets/general/table_history.dart';

import '../controllers/user_history_controller.dart';

class UserHistoryView extends GetView<UserHistoryController> {
  const UserHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preeclampsia History',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 12),

                    // Filter chips
                    // SizedBox(
                    //   height: 40,
                    //   child: ListView.separated(
                    //     scrollDirection: Axis.horizontal,
                    //     padding: EdgeInsets.symmetric(horizontal: 16),
                    //     itemCount: controller.filters.length,
                    //     separatorBuilder: (_, __) => SizedBox(width: 8),
                    //     itemBuilder: (context, index) {
                    //       final filter = controller.filters[index];
                    //       return Obx(() {
                    //         final isSelected = controller.selectedFilter.value == filter;
                    //         return ChoiceChip(
                    //           side: BorderSide(color: Colors.amber),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //           label: Text(
                    //             filter,
                    //             style: TextStyle(
                    //               color: isSelected ? Colors.white : Colors.black,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //           selected: isSelected,
                    //           selectedColor: Colors.amber,
                    //           onSelected: (_) => controller.changeFilter(filter),
                    //         );
                    //       });
                    //     },
                    //   ),
                    // ),
                    Container(
                      // margin: EdgeInsets.only(bottom: 16,),
                      // width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ), // Outer border
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: MapRotChart(data: controller.chartData.value),
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),

              // Main list using RiskCard
              if (controller.filteredData.isEmpty)
                SliverFillRemaining(child: Center(child: Text('history Empty')))
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = controller.filteredData[index];

                    return TableHistory(
                      title: item['title']!,
                      subtitle: "Preeclampsia Category",
                      icon: Icons.insert_drive_file,
                      iconColor: controller.getIconColor(item['level']!),
                      headers: ["DATE", "MAP", "ROT", "BMI", "SCALE"],
                      data: List.generate(
                        4,
                        (_) => [
                          "${item['time']} ${item['date']}",
                          "93",
                          "25",
                          "23,4",
                          "23,4",
                        ],
                      ),
                    );
                  }, childCount: controller.filteredData.length),
                ),
            ],
          ),
        );
      }),
    );
  }
}
