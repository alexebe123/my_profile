import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/about_screen.dart';
import 'package:my_profile/screen/home/contact_me_screen.dart';
import 'package:my_profile/screen/dashbord/dashbord_screen.dart';
import 'package:my_profile/screen/home/info_screen.dart';
import 'package:my_profile/screen/home/project_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget _fileItem({
    required IconData icon,
    required String label,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color ?? Colors.white70),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  static Widget techCircle(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF0E1622),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF17212B)),
      ),
      child: Center(
        child: FaIcon(icon, color: AppConstant.accentBlue, size: 18),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final PageController _pageController = PageController();

  @override
  initState() {
    super.initState();
    Provider.of<ApiServiceFirebase>(context, listen: false).getData();
    Provider.of<ApiServiceFirebase>(context, listen: false).getProducts();
    Provider.of<ApiServiceFirebase>(
      context,
      listen: false,
    ).getEducationHistory();
    Provider.of<ApiServiceFirebase>(
      context,
      listen: false,
    ).gtetExperienceHistory();
  }

  final List<Map<String, dynamic>> files = [
    {"name": "home.jsx", "icon": Icons.code, "color": Colors.cyan},
    {"name": "projects.html", "icon": Icons.html, "color": Colors.orange},
    {"name": "about.js", "icon": Icons.javascript, "color": Colors.amber},
    {"name": "Contact.json", "icon": Icons.data_object, "color": Colors.green},
  ];

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح الرابط: $url';
    }
  }

  final List<Widget> _pages = [
    InfoScreen(),
    ProjectScreen(),
    AboutScreen(),
    ContactMeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= 1000;
    bool isActive = false;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: 60,
                        height: 60,
                        color: AppConstant.sidebarColor,
                        child: _SocialIcon(icon: FontAwesomeIcons.copy),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          _launchUrl("https://github.com/alexebe123");
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.twitter),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          _launchUrl(
                            "https://www.facebook.com/ali.loo.591704/",
                          );
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.facebookF),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          _launchUrl("https://www.linkedin.com/in/alexebe123");
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.linkedinIn),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          _launchUrl("https://github.com/alexebe123");
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.github),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          _launchUrl("https://www.gmail.com/");
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.envelope),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          _launchUrl("https://www.tiktok.com/@alexebe123");
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.tiktok),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _launchUrl("https://www.fiverr.com/alexebe123");
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.user),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),
                          );
                        },
                        icon: _SocialIcon(icon: FontAwesomeIcons.gear),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ===== شريط جانبي ثابت (icons + files) =====
            if (isDesktop)
              Container(
                width: 220,
                color: AppConstant.sidebarColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EXPLORER',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: List.generate(files.length, (index) {
                        isActive = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              // استبدال jumpToPage بـ animateToPage لإضافة انزلاق سلس
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: Container(
                            color:
                                isActive
                                    ? const Color(0xFF161B1F)
                                    : Colors.transparent,
                            child: HomeScreen._fileItem(
                              icon: files[index]["icon"],
                              label: files[index]["name"],
                              color: files[index]["color"],
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 18),
                    const Divider(color: Colors.black45),
                    const SizedBox(height: 12),

                    // أيقونات اجتماعية رأسية
                  ],
                ),
              ),

            // ===== المحتوى الرئيسي =====
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: isDesktop ? 28 : 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---------------- Top Files Bar ----------------
                        Container(
                          height: 50,
                          color: Colors.black, // خلفية سوداء ثابتة
                          child: Row(
                            children: List.generate(files.length, (index) {
                              final isActive = selectedIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    // استبدال jumpToPage بـ animateToPage لإضافة انزلاق سلس
                                    _pageController.animateToPage(
                                      index,
                                      duration: const Duration(
                                        milliseconds: 900,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color:
                                        isActive
                                            ? const Color(0xFF0D1117)
                                            : Colors
                                                .transparent, // خلفية صفراء للنشط
                                    border: Border(
                                      top: BorderSide(
                                        color:
                                            isActive
                                                ? Colors.yellow
                                                : Colors
                                                    .transparent, // خط أصفر أعلى النشط
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  width: 140,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        files[index]["icon"],
                                        color: files[index]["color"],
                                        size: 30,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        files[index]["name"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 700,
                          width: 1000,
                          child: PageView(
                            controller: _pageController,
                            children: _pages,
                            // تمكين التمرير إذا أراد المستخدم السحب اليدوي مع الاحتفاظ بسلاسة الانتقال
                            physics: const BouncingScrollPhysics(),
                          ),
                        ),

                        // ---------------- Main Content ----------------
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCardExperienceWidget extends StatelessWidget {
  const InfoCardExperienceWidget({
    super.key,
    required this.name,
    required this.jobStyle,
    required this.job,
    required this.duration,
  });
  final String name;
  final String jobStyle;
  final String job;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 2, // سماكة الخط
          height: 80, // طول الخط
          color: Colors.grey[700], // لون الخط
        ),
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: AppConstant.nameYellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text(jobStyle, style: TextStyle(color: Colors.white70)),
            SizedBox(height: 6),
            Text(job, style: TextStyle(color: Colors.white70)),
            SizedBox(height: 6),
            Text(duration, style: TextStyle(color: Colors.redAccent)),
            SizedBox(height: 14),
          ],
        ),
      ],
    );
  }
}

class InfoCardEducationWidget extends StatelessWidget {
  final String _educationInstitution;
  final String _educationCompany;
  final String _educationYear;

  const InfoCardEducationWidget({
    super.key,
    required String educationInstitution,
    required String educationCompany,
    required String educationYear,
  }) : _educationInstitution = educationInstitution,
       _educationCompany = educationCompany,
       _educationYear = educationYear;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 21, 23, 26),
      child: Row(
        children: [
          Container(
            width: 2, // سماكة الخط
            height: 60, // طول الخط
            color: Colors.grey[700], // لون الخط
          ),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _educationInstitution,
                style: TextStyle(
                  color: AppConstant.nameYellow,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6),
              SizedBox(
                width: 400,
                child: Text(
                  _educationCompany,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 6),
              Text(_educationYear, style: TextStyle(color: Colors.redAccent)),
              SizedBox(height: 14),
            ],
          ),
        ],
      ),
    );
  }
}

// --- social icon widget (for sidebar) ---
class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Center(child: FaIcon(icon, size: 25, color: Colors.white70)),
    );
  }
}
