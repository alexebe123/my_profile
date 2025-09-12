import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/widget/info_card_education.dart';
import 'package:my_profile/screen/widget/info_cart_experience.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatelessWidget {
  ProfileSettings({super.key});
  Future<Uint8List?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      return result.files.single.bytes;
    }
  }

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
                        onPressed: () async {
                          final image = await pickImage();
                          final urlImage =
                              await Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).uploadPhoto(image!);
                          Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).profileModel.imageUrl =
                              urlImage;
                          await Provider.of<ApiServiceFirebase>(
                            context,
                            listen: false,
                          ).updateProfile(
                            Provider.of<ApiServiceFirebase>(
                              context,
                              listen: false,
                            ).profileModel,
                          );
                        },
                        child: const Text("Upload New Photo"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // --- Responsive Grid ---
                infoCardEducation(context, true),
                infoCardExperience(context, true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
