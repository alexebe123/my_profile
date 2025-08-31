import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1418),
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'monospace'),
      ),
      home: PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  PortfolioPage({super.key});

  static const Color sidebarColor = Color(0xFF0B0F12);
  static const Color panelColor = Color(0xFF12161A);
  static const Color accentBlue = Color(0xFF5AA7FF);
  static const Color nameYellow = Color(0xFFF2E089);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();

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

  static Widget _techCircle(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF0E1622),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF17212B)),
      ),
      child: Center(child: FaIcon(icon, color: accentBlue, size: 18)),
    );
  }
}

class _PortfolioPageState extends State<PortfolioPage> {
  // استخدم الرابط الذي أعطيتني
  final String profileImage =
      'https://bpcfdupkxxalmryqdkym.supabase.co/storage/v1/object/public/images/1756482500823.jpg';

  int selectedIndex = 0;

  final List<Map<String, dynamic>> files = [
    {"name": "home.jsx", "icon": Icons.code, "color": Colors.cyan},
    {"name": "about.html", "icon": Icons.html, "color": Colors.orange},
    {"name": "projects.js", "icon": Icons.javascript, "color": Colors.amber},
    {"name": "resume.json", "icon": Icons.data_object, "color": Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= 1000;
    final isTablet = w >= 700 && w < 1000;

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
                    children: const [
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.copy),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.twitter),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.facebookF),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.linkedinIn),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.github),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.envelope),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.tiktok),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.envelope),
                    ],
                  ),
                  Column(
                    children: [
                      _SocialIcon(icon: FontAwesomeIcons.user),
                      SizedBox(height: 10),
                      _SocialIcon(icon: FontAwesomeIcons.gear),
                    ],
                  ),
                ],
              ),
            ),

            // ===== شريط جانبي ثابت (icons + files) =====
            if (isDesktop)
              Container(
                width: 220,
                color: PortfolioPage.sidebarColor,
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
                    PortfolioPage._fileItem(
                      icon: Icons.code,
                      label: 'home.jsx',
                      color: Colors.cyan,
                    ),
                    PortfolioPage._fileItem(
                      icon: Icons.html,
                      label: 'about.html',
                      color: Colors.orange,
                    ),
                    PortfolioPage._fileItem(
                      icon: Icons.javascript,
                      label: 'projects.js',
                      color: Colors.amber,
                    ),
                    PortfolioPage._fileItem(
                      icon: Icons.data_object,
                      label: 'resume.json',
                      color: Colors.green,
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

                        // ---------------- Content ----------------
                        const SizedBox(height: 20),

                        // -------- Profile and Info Row --------
                        // Header (avatar + name + details)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar with blue stroke
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: PortfolioPage.accentBlue,
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: isTablet ? 52 : (isDesktop ? 70 : 48),
                                backgroundImage: NetworkImage(profileImage),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Name & info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ala Eddine Abbassi',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      color: PortfolioPage.nameYellow,
                                      fontSize: isDesktop ? 34 : 20,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'AI Software Developer',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: isDesktop ? 16 : 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '5+ Years of Dev Experience',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: isDesktop ? 14 : 12,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Freelance, Remote & Hybrid',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: isDesktop ? 14 : 12,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Founder of ',
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Sarcastic Geeks Trybe',
                                          style: TextStyle(
                                            color: PortfolioPage.accentBlue,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 26),

                        // Tech Stack row
                        Text(
                          '⚡ Tech Stack',
                          style: TextStyle(
                            color: PortfolioPage.accentBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Divider(color: Colors.black45),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            PortfolioPage._techCircle(
                              FontAwesomeIcons.bootstrap,
                            ),
                            PortfolioPage._techCircle(
                              FontAwesomeIcons.wordpress,
                            ),
                            PortfolioPage._techCircle(FontAwesomeIcons.js),
                            PortfolioPage._techCircle(FontAwesomeIcons.react),
                            PortfolioPage._techCircle(FontAwesomeIcons.nodeJs),
                            PortfolioPage._techCircle(
                              FontAwesomeIcons.database,
                            ),
                            PortfolioPage._techCircle(
                              FontAwesomeIcons.ethereum,
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Education & Experience cards
                        isDesktop
                            ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _infoCardEducation()),
                                const SizedBox(width: 18),
                                Expanded(child: _infoCardExperience()),
                              ],
                            )
                            : Column(
                              children: [
                                _infoCardEducation(),
                                const SizedBox(height: 12),
                                _infoCardExperience(),
                              ],
                            ),
                        const SizedBox(height: 40),
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

  Widget _infoCardEducation() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: PortfolioPage.panelColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '🎓 Education History',
            style: TextStyle(
              color: PortfolioPage.accentBlue,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),
          Divider(color: Colors.black45),
          SizedBox(height: 10),
          Text(
            'iBukas Developer Experiment Lab',
            style: TextStyle(
              color: PortfolioPage.nameYellow,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Bukas Global Investments',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text('2022 - Present', style: TextStyle(color: Colors.redAccent)),
          SizedBox(height: 14),
          Text(
            'FULL-STACK WITH HTML, CSS, JAVASCRIPT, NODE, REACT, POSTGRESQL, WEB3 AND DAPPS',
            style: TextStyle(
              color: PortfolioPage.nameYellow,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Udemy INC. and Dr Angela Yu',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text('2022 - 2024', style: TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }

  Widget _infoCardExperience() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: PortfolioPage.panelColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '💼 Professional Experience',
            style: TextStyle(
              color: PortfolioPage.accentBlue,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),
          Divider(color: Colors.black45),
          SizedBox(height: 10),
          Text(
            'Advertorial Hub',
            style: TextStyle(
              color: PortfolioPage.nameYellow,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Remote: Lagos State, Nigeria',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text(
            'Backend Developer with Express',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text('2025 - Present', style: TextStyle(color: Colors.redAccent)),
          SizedBox(height: 14),
          Text(
            'Virtuous Tech Enterprise',
            style: TextStyle(
              color: PortfolioPage.nameYellow,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Remote: Edo State, Nigeria',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text(
            'Frontend Developer with React',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text('2024', style: TextStyle(color: Colors.redAccent)),
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
