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
        scaffoldBackgroundColor: const Color(0xFF0B0F13),
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'monospace'),
      ),
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  // غيّر هذا إلى رابط صورتك
  final String profileImage = 'https://i.pravatar.cc/400?u=portfolio-sample';

  static const Color background = Color(0xFF0B0F13);
  static const Color sidebarColor = Color(0xFF0E1114);
  static const Color panelColor = Color(0xFF111418);
  static const Color cardColor = Color(0xFF0F1418);
  static const Color accentBlue = Color(0xFF4EA8FF);
  static const Color nameYellow = Color(0xFFF2E089);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= 1000;
    final isTablet = w >= 700 && w < 1000;

    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- الشريط الجانبي (desktop only) ----
            if (isDesktop)
              Container(
                width: 220,
                color: sidebarColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
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
                    _fileRow(
                      icon: Icons.code,
                      label: 'home.jsx',
                      color: Colors.cyan,
                    ),
                    _fileRow(
                      icon: Icons.html,
                      label: 'about.html',
                      color: Colors.orange,
                    ),
                    _fileRow(
                      icon: Icons.javascript,
                      label: 'projects.js',
                      color: Colors.amber,
                    ),
                    _fileRow(
                      icon: Icons.data_object,
                      label: 'resume.json',
                      color: Colors.green,
                    ),
                    const SizedBox(height: 18),
                    const Divider(color: Colors.black45),
                    const SizedBox(height: 12),
                    // أيقونات عمودية على يسار التصميم
                    Column(
                      children: [
                        _squareIcon(Icons.facebook),
                        const SizedBox(height: 8),
                        _squareIcon(Icons.link_off),
                        const SizedBox(height: 8),
                        _squareIcon(Icons.email),
                        const SizedBox(height: 8),
                        _squareIcon(Icons.settings),
                      ],
                    ),
                  ],
                ),
              ),

            if (isDesktop) const SizedBox(width: 18),

            // ---- المحتوى الرئيسي ----
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: isDesktop ? 32 : 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ----- أعلى الصفحة: الصورة + الاسم -----
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // صورة دائرية مع إطار أزرق
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: accentBlue, width: 3),
                              ),
                              child: CircleAvatar(
                                radius: isTablet ? 52 : (isDesktop ? 70 : 48),
                                backgroundImage: NetworkImage(profileImage),
                                backgroundColor: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // النصوص بجانب الصورة
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Izuka Chigozie Emmanuel Brain',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: isDesktop ? 34 : 22,
                                      fontWeight: FontWeight.w800,
                                      color: nameYellow,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
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
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Sarcastic Geeks Trybe',
                                          style: TextStyle(
                                            color: accentBlue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
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

                        const SizedBox(height: 28),

                        // ----- Tech Stack -----
                        Text(
                          '⚡ Tech Stack',
                          style: TextStyle(
                            color: accentBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _techIcon(FontAwesomeIcons.bootstrap),
                            _techIcon(FontAwesomeIcons.wordpress),
                            _techIcon(FontAwesomeIcons.react),
                            _techIcon(FontAwesomeIcons.nodeJs),
                            _techIcon(FontAwesomeIcons.github),
                            _techIcon(FontAwesomeIcons.database),
                            _techIcon(FontAwesomeIcons.ethereum),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // ----- Education & Experience (Cards) -----
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

  // ---- Widgets صغيرة ----
  static Widget _fileRow({
    required IconData icon,
    required String label,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color ?? Colors.white70),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  static Widget _squareIcon(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1116),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: Colors.white70),
    );
  }

  Widget _techIcon(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF0E1622),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF17212B)),
      ),
      child: Center(child: FaIcon(icon, size: 18, color: accentBlue)),
    );
  }

  Widget _infoCardEducation() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎓 Education History',
            style: TextStyle(
              color: accentBlue,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black45),
          const SizedBox(height: 10),
          Text(
            'iBukas Developer Experiment Lab',
            style: TextStyle(color: nameYellow, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Bukas Global Investments',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text('2022 - Present', style: TextStyle(color: Colors.redAccent)),
          const SizedBox(height: 14),
          Text(
            'FULL-STACK WITH HTML, CSS, JAVASCRIPT, NODE, REACT, POSTGRESQL, WEB3 AND DAPPS',
            style: TextStyle(color: nameYellow, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Udemy INC. and Dr Angela Yu',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text('2022 - 2024', style: TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }

  Widget _infoCardExperience() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💼 Professional Experience',
            style: TextStyle(
              color: accentBlue,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black45),
          const SizedBox(height: 10),
          Text(
            'Advertorial Hub',
            style: TextStyle(color: nameYellow, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Remote: Lagos State, Nigeria',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            'Backend Developer with Express',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text('2025 - Present', style: TextStyle(color: Colors.redAccent)),
          const SizedBox(height: 14),
          Text(
            'Virtuous Tech Enterprise',
            style: TextStyle(color: nameYellow, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Remote: Edo State, Nigeria',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            'Frontend Developer with React',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text('2024', style: TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }
}
