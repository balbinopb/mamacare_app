import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/controllers/user/history_controller.dart';
import 'package:mamacare/widgets/table_history.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preeclampsia History'),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),

          // Filter chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.filters.length,
              separatorBuilder: (_, __) => SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = controller.filters[index];
                return Obx(() {
                  final isSelected = controller.selectedFilter.value == filter;
                  return ChoiceChip(
                    side: BorderSide(color: Colors.amber),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Colors.amber,
                    onSelected: (_) => controller.changeFilter(filter),
                  );
                });
              },
            ),
          ),

          SizedBox(height: 16),

          // Main list using RiskCard
          Expanded(
            child: Obx(() {
              if (controller.filteredData.isEmpty) {
                return Center(child: Text('No history found'));
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.filteredData.length,
                itemBuilder: (context, index) {
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
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
