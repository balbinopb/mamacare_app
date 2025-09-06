import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool hasEditIcon;
  final VoidCallback? onTap;

  const InputField({
    super.key,
    required this.label,
    required this.hintText,
    this.hasEditIcon = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hintText,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(0xFF82909C),
                  ),
                ),
                if (hasEditIcon)
                  Icon(Icons.edit, size: 18, color: Colors.black),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
