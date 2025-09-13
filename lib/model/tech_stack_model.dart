class TechStack {
  String id = "";
  String name = "";

  TechStack.empty();

  TechStack.fromJson(Map<String, dynamic> json) {
    try {
      id = json['\$id'];
    } catch (e) {}
    try {
      name = json['name'];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    return data;
  }
}
