class ProjectModel {
  String id = "";
  String name = "";
  String description = "";
  String imageUrl = "";
  String linkGithub = "";
  String linkLiveDemo = "";
  String status = ""; // 0: In Progress, 1: Completed


  ProjectModel.empty();

  ProjectModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['\$id'];
    } catch (e) {}
    try {
      name = json['name'];
    } catch (e) {}
    try {
      description = json['description'];
    } catch (e) {}
    try {
      imageUrl = json['imageUrl'];
    } catch (e) {}
    try {
      linkGithub = json['linkGithub'];
    } catch (e) {}
    try {
      linkLiveDemo = json['linkLiveDemo'];
    } catch (e) {}
    try {
      status = json['status'];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['name'] = name;
    } catch (e) {}
    try {
      data['description'] = description;
    } catch (e) {}
    try {
      data['imageUrl'] = imageUrl;
    } catch (e) {}
    try {
      data['linkGithub'] = linkGithub;
    } catch (e) {}
    try {
      data['linkLiveDemo'] = linkLiveDemo;
    } catch (e) {}
    try {
      data['status'] = status;
    } catch (e) {}
    return data;
  }
}
