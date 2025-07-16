import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/views/home_screen.dart';
import 'package:mamacare/widgets/custom_textfield.dart';
import 'package:mamacare/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            children: [
              LoginHeader(),
              CustomTextfield(title: "Email", placeholder: "Email"),
              CustomTextfield(
                title: "Password",
                placeholder: "Password",
                isbscure: true,
              ),
              SizedBox(height: 30),
              Text(
                "Forgot Password?",
                style: GoogleFonts.poppins(
                  color: Color(0xFFFBCC25),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      //login logic
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFFFBCC25),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text("Login", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
