import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/widgets/general/header_clipper.dart';

class LoginHeader extends StatelessWidget {
  final String first;
  final String second;
  const LoginHeader({super.key, required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(),
      child: Container(
        height: 320,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.yellow1, AppColors.yellow2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 64, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                first,
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 12),
              Text(
                second,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
