import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/widget/info_card_education.dart';
import 'package:my_profile/screen/widget/info_cart_experience.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  Future<Uint8List?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      return result.files.single.bytes;
    }
    return null;
  }

  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _emailController = TextEditingController(
    text: "",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "",
  );
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    _nameController.text =
        Provider.of<ApiServiceFirebase>(
          context,
          listen: false,
        ).profileModel.name;
    _emailController.text =
        Provider.of<ApiServiceFirebase>(
          context,
          listen: false,
        ).profileModel.email;
    _passwordController.text =
        Provider.of<ApiServiceFirebase>(
          context,
          listen: false,
        ).profileModel.password;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? "Enter your Name"
                                        : null,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? "Enter your Email"
                                        : null,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? "Enter your Password"
                                        : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final pickedImage = await pickImage();
                            if (pickedImage != null) {
                              setState(() {
                                image = pickedImage;
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                (image != null)
                                    ? MemoryImage(image!)
                                    : NetworkImage(
                                          Provider.of<ApiServiceFirebase>(
                                            context,
                                          ).profileModel.imageUrl,
                                        )
                                        as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            if (image != null) {
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
                            }
                            Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).profileModel.name =
                                _nameController.text;
                            Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).profileModel.email =
                                _emailController.text;
                            Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).profileModel.password =
                                _passwordController.text;
                            Provider.of<ApiServiceFirebase>(
                                  context,
                                  listen: false,
                                ).profileModel.name =
                                _nameController.text;

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
                          child: const Text("Save"),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                      width: 550,
                      child: infoCardEducation(context, true),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 500,
                      child: infoCardExperience(context, true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
