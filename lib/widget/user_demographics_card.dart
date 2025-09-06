import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class UserDemographicsCard extends StatefulWidget {
  const UserDemographicsCard({super.key});

  @override
  State<UserDemographicsCard> createState() => _UserDemographicsCardState();
}

class _UserDemographicsCardState extends State<UserDemographicsCard> {
  int touchedIndex = -1;

  final List<Map<String, dynamic>> data = [
    {"label": "Blue Users", "value": 30.0, "color": Colors.blue},
    {"label": "Green Users", "value": 25.0, "color": Colors.green},
    {"label": "Orange Users", "value": 25.0, "color": Colors.orange},
    {"label": "Red Users", "value": 20.0, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "User Demographics",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          response == null ||
                          response.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          response.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sections: data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  final isTouched = index == touchedIndex;
                  final double radius = isTouched ? 70 : 60;
                  final double fontSize = isTouched ? 20 : 14;

                  return PieChartSectionData(
                    color: item["color"],
                    value: item["value"],
                    radius: radius,
                    title: "${item["value"].toInt()}",
                    titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Legend
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: data
                .map((item) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: item["color"],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(item["label"],
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
