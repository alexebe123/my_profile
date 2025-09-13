import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TechStack {
  static IconData teck(String name) {
    switch (name.toLowerCase()) {
      case "flutter":
        return FontAwesomeIcons.flutter; // أيقونة موبايل
      case "dart":
        return FontAwesomeIcons.code; // أيقونة كود
      case "php":
        return FontAwesomeIcons.php;
      case "python":
        return FontAwesomeIcons.python;
      case "javascript":
        return FontAwesomeIcons.js;
      case "java":
        return FontAwesomeIcons.java;
      case "swift":
        return FontAwesomeIcons.swift;
      case "kotlin":
        return FontAwesomeIcons.k;
      case "html":
        return FontAwesomeIcons.html5;
      case "css":
        return FontAwesomeIcons.css3;
      case "react":
        return FontAwesomeIcons.react;
      case "nodejs":
        return FontAwesomeIcons.nodeJs;
      default:
        return FontAwesomeIcons.question; // أيقونة افتراضية
    }
  }

  String name = "";
  TechStack({required this.name});

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
