import 'package:flutter/material.dart';

class ProjectDashbordScreen extends StatelessWidget {
  const ProjectDashbordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF333333),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Create New Project',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Projects Grid
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: const [
                ProjectCard(
                  title: 'Project Auterniting',
                  status: 'Active',
                  statusColor: Color(0xFF4CAF50),
                ),
                ProjectCard(
                  title: 'Project',
                  status: 'Completed',
                  statusColor: Color(0xFF2196F3),
                ),
                ProjectCard(
                  title: 'Projects',
                  status: 'On Hold',
                  statusColor: Color(0xFF9E9E9E),
                ),
                ProjectCard(
                  title: 'Project Exade',
                  status: 'On Hold',
                  statusColor: Color(0xFF9E9E9E),
                ),
                ProjectCard(
                  title: 'Sucluess',
                  status: 'On Hold',
                  statusColor: Color(0xFF9E9E9E),
                ),
                ProjectCard(
                  title: 'Witeut Eramianins',
                  status: 'Active',
                  statusColor: Color(0xFF4CAF50),
                ),
                ProjectCard(
                  title: 'Troject Mand',
                  status: 'On Hold',
                  statusColor: Color(0xFF9E9E9E),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;

  const ProjectCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Placeholder text as in the image
          const Text(
            'Orey pram dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildActionButton(Icons.edit, 'Edit'),
              const SizedBox(width: 8),
              _buildActionButton(Icons.delete, 'Delete'),
              const SizedBox(width: 8),
              _buildActionButton(Icons.visibility, 'View Details'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF6B6B6B),
          side: const BorderSide(color: Color(0xFFE0E0E0)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
