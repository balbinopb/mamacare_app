

import 'package:flutter/material.dart';

class RiwayatTable extends StatelessWidget {
  const RiwayatTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.insert_drive_file,
                    color: Color(0xFFB91C1C),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Abnormal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '70 – 90 mmHg',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DataTable(
                columnSpacing: 12,
                headingRowHeight: 36,
                // ignore: deprecated_member_use
                dataRowHeight: 36,
                horizontalMargin: 16,
                headingRowColor: WidgetStateProperty.all(Colors.white),
                columns: const [
                  DataColumn(label: Text('DATE')),
                  DataColumn(label: Text('AGE')),
                  DataColumn(label: Text('MAP')),
                  DataColumn(label: Text('ROT')),
                  DataColumn(label: Text('BMI')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('10:00 01-03-25')),
                    DataCell(Text('3')),
                    DataCell(Text('100.0')),
                    DataCell(Text('15')),
                    DataCell(Text('26.4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('11:00 01-04-25')),
                    DataCell(Text('4')),
                    DataCell(Text('105.0')),
                    DataCell(Text('19')),
                    DataCell(Text('26.9')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('10:00 15-07-25')),
                    DataCell(Text('7')),
                    DataCell(Text('95.3')),
                    DataCell(Text('10')),
                    DataCell(Text('28.4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('16:00 01-08-25')),
                    DataCell(Text('8')),
                    DataCell(Text('116.0')),
                    DataCell(Text('21')),
                    DataCell(Text('28.9')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('14:00 15-08-25')),
                    DataCell(Text('8')),
                    DataCell(Text('118.5')),
                    DataCell(Text('22')),
                    DataCell(Text('29.5')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('16:00 01-09-25')),
                    DataCell(Text('9')),
                    DataCell(Text('120.7')),
                    DataCell(Text('22')),
                    DataCell(Text('30.0')),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
