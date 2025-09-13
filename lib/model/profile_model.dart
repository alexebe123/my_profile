class ProfileModel {
  String name = '';
  String id = '';
  String imageUrl = '';
  String yearsOfExperience = '';
  String email = "";
  String password = "";

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['yearsOfExperience'] = yearsOfExperience;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
