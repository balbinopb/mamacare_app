import 'package:flutter/material.dart';
import 'package:mamacare/app/constants/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  final String title;
  final String placeholder;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;

  const CustomTextfield({
    super.key,
    required this.title,
    required this.placeholder,
    this.isPassword = false,
    this.controller,
    this.errorText,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            showCursor: true,
            keyboardType: TextInputType.phone, //jika hanya input nomor
            decoration: InputDecoration(
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              errorText: widget.errorText,
              errorStyle: TextStyle(color: AppColors.yellow1),
              hintText: widget.placeholder,
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
                borderSide: BorderSide(color: AppColors.yellow1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.yellow1, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
