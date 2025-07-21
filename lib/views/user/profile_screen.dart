import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamacare/widgets/profile/input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String dateOfBirth = "11/20/2000";
  String lastPeriod = "23/03/2025";

  Future<void> _pickDate(BuildContext context, String label) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amber,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.amber),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final formatted = DateFormat('dd/MM/yyyy').format(picked);
        if (label == "Date of Birth") {
          dateOfBirth = formatted;
        } else if (label == "First Day of Last Period") {
          lastPeriod = formatted;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Back + title
              Row(
                children: [
                  Icon(Icons.arrow_back, size: 24),
                  SizedBox(width: 10),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Profile picture with edit icon
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Info fields
              InputField(label: "Email", hintText: "stefanyy@gmail.com"),
              InputField(label: "Phone Number", hintText: "081234567890"),
              InputField(
                label: "Name",
                hintText: "Stefanyy Martin",
                hasEditIcon: true,
              ),
              InputField(
                label: "Date of Birth",
                hintText: dateOfBirth,
                hasEditIcon: true,
                onTap: () => _pickDate(context, "Date of Birth"),
              ),
              InputField(
                label: "Husband's name",
                hintText: "John Martin",
                hasEditIcon: true,
              ),
              InputField(
                label: "First Day of Last Period",
                hintText: lastPeriod,
                hasEditIcon: true,
                onTap: () => _pickDate(context, "First Day of Last Period"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
