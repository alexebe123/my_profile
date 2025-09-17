import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/model/education_history_model.dart';
import 'package:my_profile/model/experience_history_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/about_screen.dart';
import 'package:my_profile/screen/home/contact_me_screen.dart';
import 'package:my_profile/screen/home/info_screen.dart';
import 'package:my_profile/screen/home/project_screen.dart';
import 'package:my_profile/screen/widget/edit_experience_card.dart';
import 'package:my_profile/screen/widget/edit_info_card_education.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  // --- File item widget ---
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

  // --- Tech circle widget ---
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
  bool isDrawerOpen = false;

  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: "",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "",
  );

  final List<Map<String, dynamic>> files = [
    {"name": "home.jsx", "icon": Icons.code, "color": Colors.cyan},
    {"name": "projects.html", "icon": Icons.html, "color": Colors.orange},
    {"name": "about.js", "icon": Icons.javascript, "color": Colors.amber},
    {"name": "Contact.json", "icon": Icons.data_object, "color": Colors.green},
  ];

  final List<Widget> _pages = [
    InfoScreen(),
    ProjectScreen(),
    AboutScreen(),
    ContactMeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    final api = Provider.of<ApiServiceFirebase>(context, listen: false);
    api.getUsersData();
    api.getSocialMediaLink();
    api.getProducts();
    api.getEducationHistory();
    api.gtetExperienceHistory();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح الرابط: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 700 && width < 1000;
    bool isActive = false;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Row(
              children: [
                // Sidebar
                _buildSidebar(isDesktop, isTablet),
                // Explorer (Desktop)
                if (isDesktop) _buildExplorer(isActive),
                // Main Content
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
                            if (isDesktop || isTablet)
                              _buildTopFilesBar(width, isDesktop),
                            SizedBox(
                              height: 700,
                              width: 1000,
                              child: PageView(
                                controller: _pageController,
                                children: _pages,
                                physics: const BouncingScrollPhysics(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Drawer (Mobile/Tablet)
          if (isDrawerOpen) _buildDrawer(isActive),
        ],
      ),
    );
  }

  Widget _buildSidebar(bool isDesktop, bool isTablet) {
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Social icons
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              (isDesktop || isTablet)
                  ? Container(
                    width: 60,
                    height: 60,
                    color: AppConstant.sidebarColor,
                    child: const _SocialIcon(icon: FontAwesomeIcons.copy),
                  )
                  : GestureDetector(
                    onTap: () {
                      setState(() {
                        isDrawerOpen = !isDrawerOpen;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: AppConstant.sidebarColor,
                      child: const _SocialIcon(icon: FontAwesomeIcons.copy),
                    ),
                  ),
              const SizedBox(height: 10),
              ..._buildSocialIconButtons(),
            ],
          ),
          // User & Settings
          Column(
            children: [
              IconButton(
                onPressed:
                    () => _launchUrl("https://www.fiverr.com/alexebe123"),
                icon: const _SocialIcon(icon: FontAwesomeIcons.user),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: _showLoginDialog,
                icon: const _SocialIcon(icon: FontAwesomeIcons.gear),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSocialIconButtons() {
    final api = Provider.of<ApiServiceFirebase>(context, listen: false);
    return [
      IconButton(
        onPressed: () => _launchUrl(api.socialMediaLinkModel.x),
        icon: const _SocialIcon(icon: FontAwesomeIcons.twitter),
      ),
      const SizedBox(height: 10),
      IconButton(
        onPressed: () => _launchUrl(api.socialMediaLinkModel.facebook),
        icon: const _SocialIcon(icon: FontAwesomeIcons.facebookF),
      ),
      const SizedBox(height: 10),
      IconButton(
        onPressed: () => _launchUrl(api.socialMediaLinkModel.linkedin),
        icon: const _SocialIcon(icon: FontAwesomeIcons.linkedinIn),
      ),
      const SizedBox(height: 10),
      IconButton(
        onPressed: () => _launchUrl(api.socialMediaLinkModel.github),
        icon: const _SocialIcon(icon: FontAwesomeIcons.github),
      ),
      const SizedBox(height: 10),
      IconButton(
        onPressed: () => _launchUrl(api.socialMediaLinkModel.instgram),
        icon: const _SocialIcon(icon: FontAwesomeIcons.instagram),
      ),
      const SizedBox(height: 10),
      IconButton(
        onPressed: () => _launchUrl(api.socialMediaLinkModel.tiktok),
        icon: const _SocialIcon(icon: FontAwesomeIcons.tiktok),
      ),
    ];
  }

  Widget _buildExplorer(bool isActive) {
    return Container(
      width: 220,
      color: AppConstant.sidebarColor,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                child: Container(
                  color:
                      isActive ? const Color(0xFF161B1F) : Colors.transparent,
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
        ],
      ),
    );
  }

  Widget _buildTopFilesBar(double width, bool isDesktop) {
    return Container(
      height: 50,
      color: Colors.black,
      child: Row(
        children: List.generate(files.length, (index) {
          final isActive = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeInOut,
                );
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              height: 50,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF0D1117) : Colors.transparent,
                border: Border(
                  top: BorderSide(
                    color: isActive ? Colors.yellow : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              width: isDesktop ? width * 0.15 : width * 0.14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Icon(
                      files[index]["icon"],
                      color: files[index]["color"],
                      size: isDesktop ? width * 0.02 : width * 0.03,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      files[index]["name"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDrawer(bool isActive) {
    return Container(
      width: 220,
      color: AppConstant.sidebarColor,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                    isDrawerOpen = false;
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                child: Container(
                  color:
                      isActive ? const Color(0xFF161B1F) : Colors.transparent,
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
        ],
      ),
    );
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(FontAwesomeIcons.arrowLeft),
                          ),
                          const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(FontAwesomeIcons.circleXmark),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLoginField(
                      icon: FontAwesomeIcons.user,
                      controller: _emailController,
                      hint: "Email",
                      validator:
                          (value) =>
                              value == null || !value.contains("@")
                                  ? "Enter a valid email"
                                  : null,
                      obscure: false,
                    ),
                    const SizedBox(height: 20),
                    _buildLoginField(
                      icon: FontAwesomeIcons.key,
                      controller: _passwordController,
                      hint: "Password",
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Enter your Passwrd"
                                  : null,
                      obscure: true,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: const Text(
                          'LogIn',
                          style: TextStyle(
                            color: Color(0xFF1C1C1E),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildLoginField({
    required IconData icon,
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    required bool obscure,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(size: 20, icon, color: const Color(0xFFC7C7C7)),
        const SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
              filled: true,
              fillColor: const Color(0xFF3A3A3C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final api = Provider.of<ApiServiceFirebase>(context, listen: false);
      if (_emailController.text == api.profileModel.email &&
          _passwordController.text == api.profileModel.password) {
        context.go('/Dashbord');
      }
    }
  }
}

// --- Experience Card Widget ---
class InfoCardExperienceWidget extends StatelessWidget {
  const InfoCardExperienceWidget({
    super.key,
    required this.experienceHistoryModel,
    required this.isEdit,
  });
  final ExperienceHistoryModel experienceHistoryModel;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 2, height: 80, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experienceHistoryModel.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppConstant.nameYellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              experienceHistoryModel.jobStyle,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            Text(
              experienceHistoryModel.jobTech,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            Text(
              "${experienceHistoryModel.startDate} - ${experienceHistoryModel.endDate}",
              style: const TextStyle(color: Colors.redAccent),
            ),
            const SizedBox(height: 14),
          ],
        ),
        if (isEdit)
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditExperienceCard(
                        isEdit: isEdit,
                        experienceHistoryModel: experienceHistoryModel,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
              ),
              IconButton(
                onPressed: () async {
                  await Provider.of<ApiServiceFirebase>(
                    context,
                    listen: false,
                  ).deleteExperienceHistory(experienceHistoryModel.id);
                },
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ],
          ),
      ],
    );
  }
}

// --- Education Card Widget ---
class InfoCardEducationWidget extends StatelessWidget {
  final bool isEdit;
  final EducationHistoryModel editEducationHistoryModel;

  const InfoCardEducationWidget({
    super.key,
    required this.isEdit,
    required this.editEducationHistoryModel,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= 1000;
    return Container(
      color: const Color.fromARGB(255, 21, 23, 26),
      child: Row(
        children: [
          Container(width: 2, height: 60, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                editEducationHistoryModel.degree,
                style: TextStyle(
                  color: AppConstant.nameYellow,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: isDesktop ? w * 0.15 : w * 0.4,
                child: Text(
                  editEducationHistoryModel.description,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${editEducationHistoryModel.startDate} - ${editEducationHistoryModel.endDate}",
                style: const TextStyle(color: Colors.redAccent),
              ),
              const SizedBox(height: 14),
            ],
          ),
          if (isEdit)
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditInfoCardEducation(
                          isEdit: isEdit,
                          educationHistoryModel: editEducationHistoryModel,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                ),
                IconButton(
                  onPressed: () async {
                    await Provider.of<ApiServiceFirebase>(
                      context,
                      listen: false,
                    ).deleteEducationHistory(editEducationHistoryModel.id);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// --- Social Icon Widget ---
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
