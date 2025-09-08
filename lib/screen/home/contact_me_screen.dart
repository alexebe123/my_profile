import 'package:flutter/material.dart';
import 'package:my_profile/model/contact_us_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:provider/provider.dart';

class ContactMeScreen extends StatefulWidget {
  const ContactMeScreen({super.key});

  @override
  State<ContactMeScreen> createState() => _ContactMeScreenState();
}

class _ContactMeScreenState extends State<ContactMeScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          "Contact Me",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        // الفورم
        Form(
          key: _formKey,
          child: SizedBox(
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // الاسم
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Enter your name"
                              : null,
                  onSaved: (value) => name = value!,
                ),
                SizedBox(height: 16),

                // الإيميل
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || !value.contains("@")
                              ? "Enter a valid email"
                              : null,
                  onSaved: (value) => email = value!,
                ),
                SizedBox(height: 16),

                // الرسالة
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Message",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Enter a message"
                              : null,
                  onSaved: (value) => message = value!,
                ),
                SizedBox(height: 20),

                // زر إرسال
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Send"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Provider.of<ApiServiceFirebase>(
                        context,
                        listen: false,
                      ).addContact(
                        ContactUsModel(
                          name: name,
                          email: email,
                          message: message,
                        ),
                      );
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Message sent!")));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
