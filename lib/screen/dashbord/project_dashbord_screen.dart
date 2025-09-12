import 'package:flutter/material.dart';
import 'package:my_profile/model/product_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/screen/widget/edit_project_screen.dart';
import 'package:photo_view/photo_view.dart';
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditProjectDialog(
                          project: ProjectModel.empty(),
                          isEdit: false,
                        );
                      },
                    );
                  },
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
            SizedBox(
              width: MediaQuery.of(context).size.width - 250,
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                shrinkWrap: true, // مهم
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 عناصر في كل صف
                  childAspectRatio: 0.88, // مربع
                  crossAxisSpacing: 10, // مسافة بين الأعمدة
                  mainAxisSpacing:
                      10, // مسافة بين الصفوف// تتحكم في الطول/العرض
                ),
                itemBuilder: (context, index) {
                  return ProjectCard(
                    projectModel:
                        Provider.of<ApiServiceFirebase>(
                          context,
                        ).projects[index],
                  );
                },
                itemCount:
                    Provider.of<ApiServiceFirebase>(context).projects.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel projectModel;
  const ProjectCard({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  projectModel.name,
                  style: const TextStyle(
                    fontSize: 24,
                    overflow: TextOverflow.ellipsis,
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  projectModel.status,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          leading: IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context); // الخروج من صفحة الصورة
                            },
                          ),
                        ),
                        backgroundColor: Colors.black,
                        body: PhotoView(
                          imageProvider: NetworkImage(projectModel.imageUrl),
                        ),
                      ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                projectModel.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Placeholder text as in the image
          Text(
            projectModel.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildActionButton(Icons.edit, 'Edit', context, projectModel),
              const SizedBox(width: 5),
              _buildActionButton(Icons.delete, 'Delete', context, projectModel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    BuildContext context,
    ProjectModel project,
  ) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () async {
          if (label == "Edit") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditProjectDialog(project: project, isEdit: true);
              },
            );
          } else {
            await Provider.of<ApiServiceFirebase>(
              context,
              listen: false,
            ).deleteProjectHistory(project.id);
          }
        },
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
