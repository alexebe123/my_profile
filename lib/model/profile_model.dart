class ProfileModel {
  String name = '';
  String id = '';
  String imageUrl = '';
  String yearsOfExperience = '';

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['yearsOfExperience'] = yearsOfExperience;
    return data;
  }
}
