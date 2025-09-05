import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home_screen.dart';
import 'package:my_profile/widget/info_card_education.dart';
import 'package:my_profile/widget/info_cart_experience.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

   
  @override
  Widget build(BuildContext context) {
    const profileImage = "https://bpcfdupkxxalmryqdkym.supabase.co/storage/v1/object/public/images/1756482500823.jpg";
    final w = MediaQuery.of(context).size.width;
    final isTablet = w >= 700 && w < 1000;
    final isDesktop = w >= 1000;
    return Column(
      children: [
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
                border: Border.all(color: AppConstant.accentBlue, width: 3),
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
                      color: AppConstant.nameYellow,
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
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextSpan(
                          text: 'Sarcastic Geeks Trybe',
                          style: TextStyle(
                            color: AppConstant.accentBlue,
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
            color: AppConstant.accentBlue,
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
            PortfolioPage.techCircle(FontAwesomeIcons.bootstrap),
            PortfolioPage.techCircle(FontAwesomeIcons.wordpress),
            PortfolioPage.techCircle(FontAwesomeIcons.js),
            PortfolioPage.techCircle(FontAwesomeIcons.react),
            PortfolioPage.techCircle(FontAwesomeIcons.nodeJs),
            PortfolioPage.techCircle(FontAwesomeIcons.database),
            PortfolioPage.techCircle(FontAwesomeIcons.ethereum),
          ],
        ),

        const SizedBox(height: 28),

        // Education & Experience cards
        isDesktop
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: infoCardEducation()),
                const SizedBox(width: 18),
                Expanded(child: infoCardExperience()),
              ],
            )
            : Column(
              children: [
                infoCardEducation(),
                const SizedBox(height: 12),
                infoCardExperience(),
              ],
            ),
        const SizedBox(height: 40),
      ],
    );
  }
}
