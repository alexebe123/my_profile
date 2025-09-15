import 'package:flutter/material.dart';
import 'package:my_profile/model/tech_stack_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:my_profile/screen/widget/info_card_education.dart';
import 'package:my_profile/screen/widget/info_cart_experience.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isTablet = w >= 700 && w < 1000;
    final isDesktop = w >= 1000;
    return SingleChildScrollView(
      child: Column(
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
                  backgroundImage: NetworkImage(
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).profileModel.imageUrl,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Name & info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Provider.of<ApiServiceFirebase>(
                        context,
                      ).profileModel.name,
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
                      '${Provider.of<ApiServiceFirebase>(context).profileModel.yearsOfExperience} Years of Dev Experience',
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
          const Text(
            '⚡ Tech Stack',
            style: TextStyle(
              color: AppConstant.accentBlue,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Divider(color: Colors.black45),
          const SizedBox(height: 12),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 700,
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // 👈 يضمن أنها عمودية
              itemCount:
                  Provider.of<ApiServiceFirebase>(
                    context,
                  ).profileModel.techStack.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    HomeScreen.techCircle(
                      TechStack.teck(
                        Provider.of<ApiServiceFirebase>(
                          context,
                        ).profileModel.techStack[index].name,
                      ),
                    ),
                    SizedBox(width: 6),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 28),

          // Education & Experience cards
          isDesktop
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: infoCardEducation(context, false)),
                  const SizedBox(width: 18),
                  Expanded(child: infoCardExperience(context, false)),
                ],
              )
              : Column(
                children: [
                  infoCardEducation(context, false),
                  const SizedBox(height: 12),
                  infoCardExperience(context, false),
                ],
              ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
