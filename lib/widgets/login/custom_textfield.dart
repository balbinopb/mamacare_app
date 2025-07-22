import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String title;
  final String placeholder;
  final bool isbscure;
  final TextEditingController? controller;

  const CustomTextfield({
    super.key,
    required this.title,
    required this.placeholder,
    this.isbscure = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isbscure,
            showCursor: true,
            decoration: InputDecoration(
              hintText: placeholder,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFAAAAAD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFFFB00B), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
