import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/models/line_chart_model.dart';
import 'package:mamacare/models/risk_card_model.dart';
import 'package:mamacare/widgets/indicator_card.dart';
import 'package:mamacare/widgets/map_rot_chart.dart';
import 'package:mamacare/widgets/risk_card.dart';
import 'package:mamacare/widgets/week_card.dart';

class HomeScreen extends StatelessWidget {
  final String name = "Steffanyy Martin";
  final String date = "01 Juni 2025";
  final String hour = "09.30 AM";

  final risk = RiskCardModel(
    title: "Preeclampsia",
    level: "High Risk",
    heartbeatPattern: [2, 2, 3, 1, 4, 0, 2, 2],
  );


  final chartData = LineChartModel(
      title: 'MAP & ROT Graphic',
      entries: [
        LineChartEntry(
          label: 'MAP',
          color: Colors.red,
          spots: const [
            FlSpot(0, 15),
            FlSpot(1, 25),
            FlSpot(2, 35),
            FlSpot(3, 65),
            FlSpot(4, 85),
            FlSpot(5, 100),
          ],
        ),
        LineChartEntry(
          label: 'ROT',
          color: Colors.amber,
          spots: const [
            FlSpot(0, 5),
            FlSpot(1, 15),
            FlSpot(2, 45),
            FlSpot(3, 95),
            FlSpot(4, 65),
            FlSpot(5, 100),
          ],
        ),
      ],
    );

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/user.png",
                        height: 54,
                        width: 54,
                        fit: BoxFit.cover,
                      ),
                    ),
          
                    const SizedBox(width: 12),
          
                    // Greeting and Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hai, $name",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
          
                        const SizedBox(height: 4),
          
                        Text(
                          "$hour  $date",
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
          
                const SizedBox(height: 24),
          
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int week = 9; week < 17; week++)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: WeekCard(week: week),
                        ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 24),
          
                RiskCard(data: risk),
          
                const SizedBox(height: 24),
          
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
                      iconColor: Color(0xFFFBCC25),
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
                const SizedBox(height: 24),
                Text(
                  "Latest Report",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          
                MapRotChart(data: chartData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
