import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/res/app_constant.dart';

class DashbordInfoScreen extends StatelessWidget {
  const DashbordInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header and profile section
              const _DashboardHeader(),
              const SizedBox(height: 32),
              // Stats cards
              const _StatsCards(),
              const SizedBox(height: 32),
              // Recent projects and chart
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(flex: 2, child: _RecentProjects()),
                  const SizedBox(width: 32),
                  const Expanded(flex: 3, child: _AnalyticsChart()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _RecentProjects extends StatelessWidget {
  const _RecentProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstant.panelColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Projects',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // Table header
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'Project',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Expanded(
                  child: Text('Date', style: TextStyle(color: Colors.white70)),
                ),
                Expanded(
                  child: Text(
                    'Status',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white12, height: 24),
            // Project items
            _ProjectRow(
              project: 'Portfolio Website',
              date: 'Apr 10, 2023',
              status: 'Completed',
              statusColor: Colors.green,
            ),
            _ProjectRow(
              project: 'E-commerce Platform',
              date: 'Mar 22, 2023',
              status: 'Ongoing',
              statusColor: Colors.blue,
            ),
            _ProjectRow(
              project: 'Chat Application',
              date: 'Feb 15, 2023',
              status: 'Ongoing',
              statusColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final String project;
  final String date;
  final String status;
  final Color statusColor;

  const _ProjectRow({
    Key? key,
    required this.project,
    required this.date,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(project, style: const TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text(date, style: const TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsChart extends StatelessWidget {
  const _AnalyticsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstant.panelColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analytics',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'Jan';
                              break;
                            case 1:
                              text = 'Feb';
                              break;
                            case 2:
                              text = 'Mar';
                              break;
                            case 3:
                              text = 'Apr';
                              break;
                            case 4:
                              text = 'May';
                              break;
                            case 5:
                              text = 'Jun';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return Text(text, style: style);
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3.4),
                        FlSpot(1, 4.2),
                        FlSpot(2, 5.0),
                        FlSpot(3, 5.8),
                        FlSpot(4, 7.5),
                        FlSpot(5, 8.2),
                      ],
                      isCurved: true,
                      color: const Color(0xFF6B48FF),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF6B48FF).withOpacity(0.3),
                            const Color(0xFF6B48FF).withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Page Title
        const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // Notification and Profile
        Row(
          children: [
            // Notification Icon
            const Icon(Icons.notifications_none, color: Colors.white, size: 30),
            const SizedBox(width: 24),
            // Profile Image
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(
                  image: NetworkImage(
                    AppConstant.profileImage,
                  ), // Use your own image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class _StatsCards extends StatelessWidget {
  const _StatsCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _StatCard(value: '8', label: 'Completed Projects'),
        _StatCard(value: '2', label: 'Ongoing Projects'),
        _StatCard(value: '12', label: 'Clients'),
        _StatCard(value: '4.8', label: 'Average Rating'),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({Key? key, required this.value, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppConstant.panelColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
