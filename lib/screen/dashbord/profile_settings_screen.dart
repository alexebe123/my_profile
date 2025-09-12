import 'package:flutter/material.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/widget/info_card_education.dart';
import 'package:my_profile/screen/widget/info_cart_experience.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppConstant.panelColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "My Profile & Settings",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // --- الصورة الشخصية ---
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          Provider.of<ApiServiceFirebase>(
                            context,
                          ).profileModel.imageUrl,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Upload New Photo"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // --- Responsive Grid ---
                infoCardEducation(context,true),
                infoCardExperience(context,true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
