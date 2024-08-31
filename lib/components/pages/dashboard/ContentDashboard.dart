import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/components/pages/dashboard/AnalyticChart.dart';
import 'package:flutter_application_1/components/pages/dashboard/DashboardCard.dart';

class ContentDashboard extends StatelessWidget {
  final bool isMobile;

  const ContentDashboard({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Grid untuk 4 card
              Expanded(
                flex: 2,
                child: GridView.count(
                  crossAxisCount: isMobile ? 2 : 4,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    DashboardCard(title: 'Revenue', amount: '\$30,000', percentage: 12),
                    DashboardCard(title: 'Sales', amount: '\$15,000', percentage: -5),
                    DashboardCard(title: 'Profit', amount: '\$8,000', percentage: 7),
                    DashboardCard(title: 'Expenses', amount: '\$5,000', percentage: -2),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Baris untuk grafik analitik
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: AnalyticsChart(
                        title: 'Cash Transactions',
                        color: Colors.blue,
                        dataPoints: [
                          FlSpot(0, 1),
                          FlSpot(1, 3),
                          FlSpot(2, 10),
                          FlSpot(3, 7),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AnalyticsChart(
                        title: 'Transfer Transactions',
                        color: Colors.green,
                        dataPoints: [
                          FlSpot(0, 2),
                          FlSpot(1, 5),
                          FlSpot(2, 9),
                          FlSpot(3, 6),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
