import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/modules/admin/verify_otp/controllers/verify_otp_controller.dart';
import 'package:mamacare/app/widgets/general/login_header.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    // Create 6 controllers for 6-digit OTP
    final otpControllers = List.generate(6, (_) => TextEditingController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LoginHeader(
              first: "Verify OTP",
              second: "Enter the code sent to your phone",
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // spacing: Checkbox.width,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    child: TextField(
                      controller: otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        counterText: '',
                        // errorText: widget.errorText,
                        errorStyle: TextStyle(color: AppColors.yellow1),
                        // hintText: widget.placeholder,
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
                          borderSide: BorderSide(
                            color: Color(0xFFFFB00B),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.yellow1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.yellow1,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();// move to next field
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();// move back when deletingg
                        }

                        // update controller's otp value
                        controller.otpController.text = otpControllers
                            .map((c) => c.text)
                            .join();
                      },
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
              child: SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return FilledButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            await controller.verifyOtp(
                              otp: controller.otpController.text.trim(),
                            );
                          },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.yellow1,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Verify OTP",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
