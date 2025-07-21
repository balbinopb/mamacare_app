import 'package:flutter/material.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hintText, style: TextStyle(fontSize: 16)),
                if (hasEditIcon) Icon(Icons.edit, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
