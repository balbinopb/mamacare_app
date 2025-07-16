import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekCard extends StatelessWidget {
  final int week;
  const WeekCard({super.key, required this.week});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = week == 9;

    return Container(
      height: 68,
      width: 51,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFBCC25) : Colors.transparent,
        border: Border.all(color: const Color(0xFFFBCC25), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Week",
            style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "$week",
            style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
