import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String amount;
  final int percentage;

  const DashboardCard({
    required this.title,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(amount, style: const TextStyle(fontSize: 24)),
            Row(
              children: [
                Icon(
                  percentage > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  color: percentage > 0 ? Colors.green : Colors.red,
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    color: percentage > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
