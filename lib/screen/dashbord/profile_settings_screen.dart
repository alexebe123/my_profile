import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/model/tech_stack_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/widget/info_card_education.dart';
import 'package:my_profile/screen/widget/info_cart_experience.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

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

  final List<String> availableLanguages = [
    "Flutter",
    "PHP",
    "Javascript",
    "Python",
    "Swift",
  ];

  List<String> selectedLanguages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedLanguages =
        Provider.of<ApiServiceFirebase>(
          context,
          listen: false,
        ).profileModel.techStack.map((e) => e.name).toList();
  }

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
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                                  Provider.of<
                                                    ApiServiceFirebase
                                                  >(
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
                            Container(
                              width: 500,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "Tech Stack",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  /// Available Languages
                                  Text(
                                    "Available Languages",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    children:
                                        availableLanguages.map((lang) {
                                          return FilterChip(
                                            label: Text(lang),
                                            selected: selectedLanguages
                                                .contains(lang),
                                            onSelected: (bool value) {
                                              setState(() {
                                                if (value) {
                                                  selectedLanguages.add(lang);
                                                } else {
                                                  selectedLanguages.remove(
                                                    lang,
                                                  );
                                                }
                                              });
                                            },
                                          );
                                        }).toList(),
                                  ),
                                  SizedBox(height: 20),

                                  /// Selected Languages
                                  Text(
                                    "Selected Languages",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Wrap(
                                      spacing: 8,
                                      children:
                                          selectedLanguages.isEmpty
                                              ? [Text("Click tags to add...")]
                                              : selectedLanguages
                                                  .map(
                                                    (lang) => Chip(
                                                      label: Text(lang),
                                                      onDeleted: () {
                                                        setState(() {
                                                          selectedLanguages
                                                              .remove(lang);
                                                        });
                                                      },
                                                    ),
                                                  )
                                                  .toList(),
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  /// Buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          backgroundColor: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          // Save logic
                                          if (selectedLanguages.isNotEmpty) {
                                            final profile =
                                                Provider.of<ApiServiceFirebase>(
                                                  context,
                                                  listen: false,
                                                ).profileModel;
                                            profile.techStack.clear();
                                            try {
                                              for (
                                                var i = 0;
                                                i < selectedLanguages.length;
                                                i++
                                              ) {
                                                profile.techStack.add(
                                                  TechStack(
                                                    name: selectedLanguages[i],
                                                  ),
                                                );
                                              }
                                              await Provider.of<
                                                ApiServiceFirebase
                                              >(
                                                context,
                                                listen: false,
                                              ).updateProfile(profile);
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                          }
                                        },
                                        child: Text("Save"),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[300],
                                          foregroundColor: Colors.black,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            selectedLanguages.clear();
                                          });
                                        },
                                        child: Text("Reset"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // --- التعلم و الخبرات ---
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
