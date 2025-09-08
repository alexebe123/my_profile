class ContactUsModel {
  String name = '';
  String email = '';
  String message = '';

  ContactUsModel({
    required this.name,
    required this.email,
    required this.message,
  });

  ContactUsModel.empty();

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    try {
      name = json['name'];
    } catch (e) {}
    try {
      email = json['email'];
    } catch (e) {}
    try {
      message = json['message'];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['name'] = name;
    } catch (e) {}
    try {
      data['email'] = email;
    } catch (e) {}
    try {
      data['message'] = message;
    } catch (e) {}
    return data;
  }
}
