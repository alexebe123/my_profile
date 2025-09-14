import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_profile/model/product_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final Map<String, String> typeMap = {
    'All': 'All',
    'Web Apps': 'web', // تأكد أن 'web' هو نفس القيمة في model
    'Mobile Apps': 'Mobile', // أو 'mobile' حسب ما تحفظ في project.type
    'Desktop App': 'Desktop',
  };

  String selectedFilter = 'All'; // القيمة الافتراضية/ القيمة الافتراضية

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final allProjects = Provider.of<ApiServiceFirebase>(context).projects;

    // خذ القيمة الداخلية المطابقة للاختيار
    String selectedTypeValue = typeMap[selectedFilter] ?? 'All';
    // فلترة بطريقة case-insensitive
    List<ProjectModel> filteredProjects =
        selectedTypeValue == 'All'
            ? allProjects
            : allProjects.where((p) {
              final pType = (p.type).toString().toLowerCase();
              return pType == selectedTypeValue.toLowerCase();
            }).toList();
    selectedTypeValue = typeMap[selectedFilter] ?? 'All';

    filteredProjects =
        allProjects.where((p) {
          final pType = (p.type).toString().toLowerCase();
          final pName = (p.name).toLowerCase();
          final matchesType =
              selectedTypeValue == 'All'
                  ? true
                  : pType == selectedTypeValue.toLowerCase();
          final matchesSearch = pName.contains(searchQuery.toLowerCase());
          return matchesType && matchesSearch;
        }).toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Title
            const Text(
              "Projects",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF5F5F5),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Filter & Search
            Row(
              children: [
                DropdownButton<String>(
                  dropdownColor: const Color(0xFF1A1A1A),
                  value: selectedFilter,
                  style: const TextStyle(color: Colors.white),
                  items:
                      ["All", "Web Apps", "Mobile Apps", "Desktop App"]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value!;
                    });
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: 200,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Projects Grid
            Expanded(
              child:
                  filteredProjects.isEmpty
                      ? const Center(
                        child: Text(
                          "No projects found",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                      : GridView.builder(
                        shrinkWrap: true, // مهم
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.8, // تتحكم في الطول/العرض
                        ),
                        itemCount: filteredProjects.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ProjectCard(
                              projectModel: filteredProjects[index],
                            ),
                          );
                        },
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح الرابط: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 صورة المشروع
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
          const SizedBox(height: 10),

          // 🔹 العنوان
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              projectModel.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // 🔹 الوصف
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              projectModel.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.flutter,
                color: Colors.blueGrey[400],
                size: 20,
              ),
              const SizedBox(width: 6),
              Icon(
                FontAwesomeIcons.dartLang,
                color: Colors.blueGrey[400],
                size: 20,
              ),
              const SizedBox(width: 6),
              Icon(
                FontAwesomeIcons.fire,
                color: Colors.blueGrey[400],
                size: 20,
              ),
              const SizedBox(width: 6),
            ],
          ),
          const SizedBox(height: 10),

          // 🔹 الأزرار
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Live Demo"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _launchUrl(projectModel.linkGithub);
                    },
                    child: const Text("GitHub"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
