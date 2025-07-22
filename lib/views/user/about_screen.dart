import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mamacare/controllers/about_controller.dart';

class AboutScreen extends GetView<AboutController> {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: BackButton(color: Colors.black),
          onPressed: Get.back,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'About ${controller.appName}',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/logo3.png', height: 120),
            const SizedBox(height: 16),
            Text(
              controller.appName,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF041560),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              controller.description,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.whatsapp,
                  size: 20,
                  color: Color(0xFF3C4550),
                ),
                const SizedBox(width: 8),
                Text(
                  controller.contactNumber,
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
