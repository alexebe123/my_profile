class ExperienceHistoryModel {
  String id = '';
  String title = '';
  String jobStyle = '';
  String jobTech = '';
  String startDate = '';
  String endDate = '';

  ExperienceHistoryModel.empty();

  ExperienceHistoryModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
    } catch (e) {}
    try {
      title = json['title'];
    } catch (e) {}
    try {
      jobStyle = json['jobStyle'];
    } catch (e) {}
    try {
      jobTech = json['jobTech'];
    } catch (e) {}
    try {
      startDate = json['startDate'];
    } catch (e) {}
    try {
      endDate = json['endDate'];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['jobStyle'] = jobStyle;
    } catch (e) {}
    try {
      data['title'] = title;
    } catch (e) {}
    try {
      data['jobTech'] = jobTech;
    } catch (e) {}
    try {
      data['startDate'] = startDate;
    } catch (e) {}
    try {
      data['endDate'] = endDate;
    } catch (e) {}
    return data;
  }
}
