class TechStack {
  String name = "";
  TechStack({
    required this.name
  });

  TechStack.empty();

  TechStack.fromJson(Map<String, dynamic> json) {
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
