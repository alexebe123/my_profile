import 'package:my_profile/model/tech_stack_model.dart';

class ProfileModel {
  String name = '';
  String id = '';
  String imageUrl = '';
  String yearsOfExperience = '';
  String email = "";
  String password = "";
  List<TechStack> techStack = [];

  ProfileModel.empty();

  ProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['\$id'];
    } catch (e) {}
    try {
      name = json['name'];
    } catch (e) {}
    try {
      imageUrl = json['imageUrl'];
    } catch (e) {}
    try {
      yearsOfExperience = json['yearsOfExperience'];
    } catch (e) {}
    try {
      email = json['email'];
    } catch (e) {}
    try {
      password = json['password'];
    } catch (e) {}
    try {
      techStack =
          (json['techStack'] as List)
              .map((e) => TechStack.fromJson(e))
              .toList();
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['yearsOfExperience'] = yearsOfExperience;
    data['email'] = email;
    data['password'] = password;
    data['techStack'] = techStack.map((e) => e.toJson()).toList();
    return data;
  }
}
