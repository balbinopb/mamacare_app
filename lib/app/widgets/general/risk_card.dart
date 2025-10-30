import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/data/models/risk_card_model.dart';
import 'package:mamacare/app/widgets/general/heartbeat_chart.dart';

class RiskCard extends StatelessWidget {
  final RiskCardModel data;
  final Map<String, dynamic> args;
  const RiskCard({super.key, required this.data, required this.args});

  @override
  Widget build(BuildContext context) {
    final userDataRef = FirebaseFirestore.instance
        .collection('sensorData')
        .doc(args['adminId'])
        .collection('users')
        .doc(args['user'].id)
        .collection('readsensor');

    return StreamBuilder<QuerySnapshot>(
      stream: userDataRef
          .orderBy('createAt', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No risk data yet'));
        }

        final latestDoc = snapshot.data!.docs.first;
        final dataMap = latestDoc.data() as Map<String, dynamic>;

        final String riskLevel = dataMap['riskLevel'] ?? 'Unknown';

        return Container(
          width: double.infinity,
          height: 138,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.yellow1, AppColors.yellow2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Text Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Preeclampsia",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "$riskLevel Risk",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              HeartbeatChart(pattern: data.heartbeatPattern),
            ],
          ),
        );
      },
    );
  }
}
