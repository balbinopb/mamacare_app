import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String title;
  final String placeholder;
  final bool isbscure;

  const CustomTextfield({
    super.key,
    required this.title,
    required this.placeholder,
    this.isbscure = false,
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
            decoration: InputDecoration(
              // suffixIcon: IconButton(
              //   onPressed: () {},
              //   icon: Icon(isbscure ? Icons.visibility_off : Icons.visibility),
              // ),
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
            ),
            obscureText: isbscure,

            showCursor: true,
          ),
        ],
      ),
    );
  }
}
