import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:provider/provider.dart';

class SocialMediaLinksScreen extends StatelessWidget {
  SocialMediaLinksScreen({super.key});
  final TextEditingController _facebookController = TextEditingController(
    text: "",
  );
  final TextEditingController _xController = TextEditingController(text: "");
  final TextEditingController _youtubeController = TextEditingController(
    text: "",
  );
  final TextEditingController _instgramController = TextEditingController(
    text: "",
  );
  final TextEditingController _fiverController = TextEditingController(
    text: "",
  );
  final TextEditingController _tiktokController = TextEditingController(
    text: "",
  );
  final TextEditingController _linkedinController = TextEditingController(
    text: "",
  );
  final TextEditingController _githubController = TextEditingController(
    text: "",
  );
  final _formKey = GlobalKey<FormState>();

  // Remove or initialize 'g' if needed, here removed as it is unused

  @override
  Widget build(BuildContext context) {
    final socialMediaLink =
        Provider.of<ApiServiceFirebase>(context).socialMediaLinkModel;
    _facebookController.text = socialMediaLink.facebook;
    _fiverController.text = socialMediaLink.fiver;
    _githubController.text = socialMediaLink.github;
    _instgramController.text = socialMediaLink.instgram;
    _linkedinController.text = socialMediaLink.linkedin;
    _tiktokController.text = socialMediaLink.tiktok;
    _xController.text = socialMediaLink.x;
    _youtubeController.text = socialMediaLink.youtube;
    return Dialog(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width - 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Edit Social Media Links",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text("Connected Accounts", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.youtube,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _youtubeController,
                                  decoration: InputDecoration(
                                    hintText: "Youtube",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.youtube =
                                            _youtubeController.text;
                                      
                                          await Provider.of<ApiServiceFirebase>(
                                            context,
                                            listen: false,
                                          ).updateSocialMediaLink(
                                            socialMediaLink,
                                          );
                                        
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.tiktok,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _tiktokController,
                                  decoration: InputDecoration(
                                    hintText: "Tiktok",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.tiktok =
                                            _tiktokController.text;
                                        Provider.of<ApiServiceFirebase>(
                                          context, listen: false,
                                        ).updateSocialMediaLink(
                                          socialMediaLink,
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.five,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _fiverController,
                                  decoration: InputDecoration(
                                    hintText: "Fiverr",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.fiver =
                                            _fiverController.text;
                                        Provider.of<ApiServiceFirebase>(
                                          context, listen: false,
                                        ).updateSocialMediaLink(
                                          socialMediaLink,
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _xController,
                                  decoration: InputDecoration(
                                    hintText: "X",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.x = _xController.text;
                                        Provider.of<ApiServiceFirebase>(
                                          context, listen: false,
                                        ).updateSocialMediaLink(
                                          socialMediaLink,
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _facebookController,
                                  decoration: InputDecoration(
                                    hintText: "Facebook",
                                    hintStyle: const TextStyle(
                                      color: Colors.blue,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.facebook =
                                            _facebookController.text;
                                        Provider.of<ApiServiceFirebase>(
                                          context, listen: false,
                                        ).updateSocialMediaLink(
                                          socialMediaLink,
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _githubController,
                                  decoration: InputDecoration(
                                    hintText: "GitHub",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.github =
                                            _githubController.text;
                                        Provider.of<ApiServiceFirebase>(
                                          context, listen: false,
                                        ).updateSocialMediaLink(
                                          socialMediaLink,
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue[900],
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.linkedin,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _linkedinController,
                                  decoration: InputDecoration(
                                    hintText: "LinkedIn",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.linkedin =
                                            _linkedinController.text;
                                        Provider.of<ApiServiceFirebase>(
                                          context, listen: false,
                                        ).updateSocialMediaLink(
                                          socialMediaLink,
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.pinkAccent,
                                radius: 20,
                                child: Icon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _instgramController,
                                  decoration: InputDecoration(
                                    hintText: "Instagram",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),

                                    suffixIcon: TextButton(
                                      onPressed: () async {
                                        socialMediaLink.instgram =
                                            _instgramController.text;
                                        Provider.of<ApiServiceFirebase>(
                                          context, listen: false,
                                        ).updateSocialMediaLink(
                                          socialMediaLink,
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
