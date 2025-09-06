import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_profile/screen/widget/user_demographics_card.dart';

class AnalyzeScreen extends StatelessWidget {
  const AnalyzeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Row(
        children: [
          // --- Content ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Top charts row
                  Row(
                    children: [
                      Expanded(
                        child: _buildCard(
                          "Visitor Numbers by Month",
                          BarChart(
                            BarChartData(
                              backgroundColor: Colors.transparent,
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      final months = [
                                        "Jan",
                                        "Feb",
                                        "Mar",
                                        "Apr",
                                        "May",
                                        "Jun",
                                        "Jul",
                                        "Aug",
                                        "Sep",
                                        "Oct",
                                        "Nov",
                                        "Dec",
                                      ];
                                      if (value.toInt() < months.length) {
                                        return Text(
                                          months[value.toInt()],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                          ),
                                        );
                                      }
                                      return const Text("");
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              barGroups: List.generate(
                                12,
                                (i) => BarChartGroupData(
                                  x: i,
                                  barRods: [
                                    BarChartRodData(
                                      toY: (i + 1) * 10 % 70 + 20,
                                      color: Colors.blueAccent,
                                      width: 12,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildCard(
                          "Website Traffic Trends",
                          LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  color: Colors.purpleAccent,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.purpleAccent.withOpacity(0.2),
                                  ),
                                  spots: const [
                                    FlSpot(0, 20),
                                    FlSpot(1, 50),
                                    FlSpot(2, 40),
                                    FlSpot(3, 80),
                                    FlSpot(4, 60),
                                    FlSpot(5, 140),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Bottom row
                  Row(
                    children: [
                      Expanded(child: UserDemographicsCard()),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                "Total Visitors",
                                "1,245,678",
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard("Emails Sent", "56,779"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(height: 200, child: child),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
