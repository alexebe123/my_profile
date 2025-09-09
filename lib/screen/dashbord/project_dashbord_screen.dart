import 'package:flutter/material.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:provider/provider.dart';

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
                    color: Colors.white,
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
              children: [
                SizedBox(
                  height: 600,
                  width: 400,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ProjectCard(
                        decription:
                            Provider.of<ApiServiceFirebase>(
                              context,
                            ).projects[index].description,
                        title:
                            Provider.of<ApiServiceFirebase>(
                              context,
                            ).projects[index].name,
                        status:
                            Provider.of<ApiServiceFirebase>(
                                      context,
                                    ).projects[index].status.toString() ==
                                    "0"
                                ? "In Progress"
                                : "Completed",
                        statusColor:
                            index % 2 == 0 ? Colors.orange : Colors.green,
                      );
                    },
                    itemCount:
                        Provider.of<ApiServiceFirebase>(
                          context,
                        ).projects.length,
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

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final String decription;
  const ProjectCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.decription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 32, 43),
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
                    color: Colors.white70,
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
          Text(
            decription,
            style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildActionButton(Icons.edit, 'Edit'),
              const SizedBox(width: 5),
              _buildActionButton(Icons.delete, 'Delete'),
              const SizedBox(width: 5),
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
            Icon(icon, size: 14),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
