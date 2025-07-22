import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String title;
  final String placeholder;
  final bool isbscure;
  final TextEditingController? controller;
  final String? errorText;

  const CustomTextfield({
    super.key,
    required this.title,
    required this.placeholder,
    this.isbscure = false,
    this.controller,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isbscure,
            showCursor: true,
            decoration: InputDecoration(
              errorText: errorText,
              errorStyle: TextStyle(color: Color(0xFFFBCC25)),
              hintText: placeholder,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFAAAAAD)),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFFFB00B), width: 2),
              ),

              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBCC25)),
                borderRadius: BorderRadius.circular(8),
              ),

              // Focused while error exists
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFBCC25), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
