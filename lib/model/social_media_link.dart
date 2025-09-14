class SocialMediaLinkModel {
  String id = "";
  String facebook = "";
  String youtube = "";
  String x = "";
  String linkedin = "";
  String tiktok = "";
  String instgram = "";
  String github = "";
  String fiver = "";

  SocialMediaLinkModel.empty();

  SocialMediaLinkModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['\$id'];
    } catch (e) {}
    try {
      facebook = json['facebook'];
    } catch (e) {}
    try {
      youtube = json['youtube'];
    } catch (e) {}
    try {
      x = json['x'];
    } catch (e) {}
    try {
      linkedin = json['linkedin'];
    } catch (e) {}
    try {
      tiktok = json['tiktok'];
    } catch (e) {}
    try {
      instgram = json['instgram'];
    } catch (e) {}
    try {
      github = json['github'];
    } catch (e) {}
    try {
      fiver = json['fiver'];
    } catch (e) {}
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['facebook'] = facebook;
    } catch (e) {}
    try {
      data['youtube'] = youtube;
    } catch (e) {}
    try {
      data['x'] = x;
    } catch (e) {}
    try {
      data['linkedin'] = linkedin;
    } catch (e) {}
    try {
      data['tiktok'] = tiktok;
    } catch (e) {}
    try {
      data['instgram'] = instgram;
    } catch (e) {}
    try {
      data['github'] = github;
    } catch (e) {}
    try {
      data['fiver'] = fiver;
    } catch (e) {}
    return data;
  }
}
