class EducationHistoryModel {
  String id = '';
  String degree = '';
  String startDate = '';
  String endDate = '';
  String description = '';

  EducationHistoryModel.empty();

  EducationHistoryModel.fromMap(Map<String, dynamic> json) {
    try {
      id = json['\$id'];
    } catch (e) {}
    try {
      degree = json['degree'];
    } catch (e) {}
    try {
      startDate = json['startDate'];
    } catch (e) {}
    try {
      endDate = json['endDate'];
    } catch (e) {}
    try {
      description = json['description'];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['degree'] = degree;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['description'] = description;
    return data;
  }
}
