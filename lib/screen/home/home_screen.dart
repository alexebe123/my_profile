import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_profile/model/education_history_model.dart';
import 'package:my_profile/model/experience_history_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/about_screen.dart';
import 'package:my_profile/screen/home/contact_me_screen.dart';
import 'package:my_profile/screen/dashbord/dashbord_screen.dart';
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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController(
    text: "",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "",
  );

  @override
  initState() {
    super.initState();
    Provider.of<ApiServiceFirebase>(context, listen: false).getUsersData();
    Provider.of<ApiServiceFirebase>(
      context,
      listen: false,
    ).getSocialMediaLink();
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
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool isDesktop = width >= 1024;
    final isTablet = width >= 700 && width < 1000;
    bool isActive = false;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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
                          (isDesktop || isTablet)
                              ? Container(
                                width: 60,
                                height: 60,
                                color: AppConstant.sidebarColor,
                                child: _SocialIcon(icon: FontAwesomeIcons.copy),
                              )
                              : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDrawerOpen = !isDrawerOpen; // فتح الدراور
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  color: AppConstant.sidebarColor,
                                  child: _SocialIcon(
                                    icon: FontAwesomeIcons.copy,
                                  ),
                                ),
                              ),

                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              _launchUrl(
                                Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).socialMediaLinkModel.x,
                              );
                            },
                            icon: _SocialIcon(icon: FontAwesomeIcons.twitter),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              _launchUrl(
                                Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).socialMediaLinkModel.facebook,
                              );
                            },
                            icon: _SocialIcon(icon: FontAwesomeIcons.facebookF),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              _launchUrl(
                                Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).socialMediaLinkModel.linkedin,
                              );
                            },
                            icon: _SocialIcon(
                              icon: FontAwesomeIcons.linkedinIn,
                            ),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              _launchUrl(
                                Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).socialMediaLinkModel.github,
                              );
                            },
                            icon: _SocialIcon(icon: FontAwesomeIcons.github),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              _launchUrl(
                                Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).socialMediaLinkModel.instgram,
                              );
                            },
                            icon: _SocialIcon(icon: FontAwesomeIcons.instagram),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              _launchUrl(
                                Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).socialMediaLinkModel.tiktok,
                              );
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(height: 10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .arrowLeft,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Login",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .circleXmark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    size: 20,
                                                    FontAwesomeIcons.user,
                                                    color: const Color(
                                                      0xFFC7C7C7,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 200,
                                                    child: TextFormField(
                                                      controller:
                                                          _emailController,
                                                      validator:
                                                          (value) =>
                                                              value == null ||
                                                                      !value
                                                                          .contains(
                                                                            "@",
                                                                          )
                                                                  ? "Enter a valid email"
                                                                  : null,
                                                      obscureText: false,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: "Email",
                                                        hintStyle:
                                                            const TextStyle(
                                                              color: Color(
                                                                0xFF8E8E93,
                                                              ),
                                                            ),
                                                        filled: true,
                                                        fillColor: const Color(
                                                          0xFF3A3A3C,
                                                        ),

                                                        // استخدام FaIcon للأيقونات
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15.0,
                                                              ),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 20),

                                              // حقل كلمة المرور مع أيقونة Font Awesome
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    size: 20,
                                                    FontAwesomeIcons.key,
                                                    color: const Color(
                                                      0xFFC7C7C7,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 200,
                                                    child: TextFormField(
                                                      controller:
                                                          _passwordController,
                                                      validator:
                                                          (value) =>
                                                              value == null ||
                                                                      value
                                                                          .isEmpty
                                                                  ? "Enter your Passwrd"
                                                                  : null,
                                                      obscureText: true,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      decoration: InputDecoration(
                                                        hintText: "Password",
                                                        hintStyle:
                                                            const TextStyle(
                                                              color: Color(
                                                                0xFF8E8E93,
                                                              ),
                                                            ),
                                                        filled: true,
                                                        fillColor: const Color(
                                                          0xFF3A3A3C,
                                                        ),

                                                        // استخدام FaIcon للأيقونات
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15.0,
                                                              ),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                ),

                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      if (_emailController
                                                                  .text ==
                                                              Provider.of<
                                                                    ApiServiceFirebase
                                                                  >(
                                                                    context,
                                                                    listen:
                                                                        false,
                                                                  )
                                                                  .profileModel
                                                                  .email &&
                                                          _passwordController
                                                                  .text ==
                                                              Provider.of<
                                                                    ApiServiceFirebase
                                                                  >(
                                                                    context,
                                                                    listen:
                                                                        false,
                                                                  )
                                                                  .profileModel
                                                                  .password) {
                                                        Navigator.of(
                                                          context,
                                                        ).pushReplacement(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    DashboardScreen(),
                                                          ),
                                                        );
                                                      } else {
                                                        return;
                                                      }
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFFFC107),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 18.0,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15.0,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'LogIn',
                                                    style: TextStyle(
                                                      color: Color(0xFF1C1C1E),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                            (isDesktop || isTablet)
                                ? Container(
                                  height: 50, // الطول ثابت

                                  color: Colors.black, // خلفية سوداء ثابتة
                                  child: Expanded(
                                    child: Row(
                                      children: List.generate(files.length, (
                                        index,
                                      ) {
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
                                            margin: const EdgeInsets.only(
                                              right: 8,
                                            ),
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
                                            width:
                                                (isDesktop)
                                                    ? width * 0.15
                                                    : width * 0.14,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Icon(
                                                    files[index]["icon"],
                                                    color:
                                                        files[index]["color"],
                                                    size:
                                                        (isDesktop)
                                                            ? width * 0.02
                                                            : width * 0.03,
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                Expanded(
                                                  child: Text(
                                                    files[index]["name"],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight
                                                              .w300, // يخليه في سطر واحد فقط
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
                                  ),
                                )
                                : SizedBox(),

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
          (isDrawerOpen)
              ? Container(
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
                              isDrawerOpen = false;
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
              )
              : SizedBox(),
        ],
      ),
    );
  }
}

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
              experienceHistoryModel.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppConstant.nameYellow,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text(
              experienceHistoryModel.jobStyle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 6),
            Text(
              experienceHistoryModel.jobTech,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 6),
            Text(
              "${experienceHistoryModel.startDate} - ${experienceHistoryModel.endDate}",
              style: TextStyle(color: Colors.redAccent),
            ),
            SizedBox(height: 14),
          ],
        ),
        (isEdit)
            ? Row(
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
            )
            : SizedBox(),
      ],
    );
  }
}

class InfoCardEducationWidget extends StatelessWidget {
  final bool isEdit;
  final EducationHistoryModel editEducationHistoryModel;

  InfoCardEducationWidget({
    super.key,
    required this.isEdit,
    required this.editEducationHistoryModel,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= 1000;
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
                editEducationHistoryModel.degree,
                style: TextStyle(
                  color: AppConstant.nameYellow,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6),
              SizedBox(
                width: (isDesktop) ? w * 0.15 : w * 0.4,
                child: Text(
                  editEducationHistoryModel.description,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 6),
              Text(
                "${editEducationHistoryModel.startDate} - ${editEducationHistoryModel.endDate}",
                style: TextStyle(color: Colors.redAccent),
              ),
              SizedBox(height: 14),
            ],
          ),
          (isEdit)
              ? Row(
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
              )
              : SizedBox(),
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
