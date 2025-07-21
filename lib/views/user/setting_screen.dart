import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/views/user/profile_screen.dart';
import 'package:mamacare/widgets/setting/info_card.dart';
import 'package:mamacare/widgets/setting/menu_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Back button and title
              Row(
                children: [
                  Icon(Icons.arrow_back, size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Setting',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Profile avatar
              CircleAvatar(
                radius: 65,
                backgroundColor: Color(0xFFFFB00B),
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
              ),
              SizedBox(height: 10),

              // Name and age
              Text(
                ' Stefanyy Martin',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '25 years old',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 30),

              // Info cards (trimester, weight, height)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoCard(
                    icon: Icons.local_fire_department,
                    label: 'Trimester',
                    value: '10',
                    unit: 'week',
                    color: Color(0xFFFAEBEB),
                    valueColor: Colors.red,
                  ),
                  InfoCard(
                    icon: Icons.monitor_weight,
                    label: 'Weight',
                    value: '55',
                    unit: 'kg',
                    color: Color(0xFFFFFAEA),
                    valueColor: Color(0xFFFBCC25),
                  ),
                  InfoCard(
                    icon: Icons.height,
                    label: 'Height',
                    value: '160',
                    unit: 'cm',
                    color: Color(0xFFEEF5F0),
                    valueColor: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 30),

              MenuTile(
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
              MenuTile(icon: Icons.info, title: 'About'),
              MenuTile(icon: Icons.logout, title: 'Logout'),
            ],
          ),
        ),
      ),
    );
  }
}
