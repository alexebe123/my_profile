import 'package:flutter/material.dart';

class ApiServiceFirebase extends ChangeNotifier {
  static ApiServiceFirebase? _instance;

  static ApiServiceFirebase get instance {
    _instance ??= ApiServiceFirebase._internal();
    return _instance!;
  }

  ApiServiceFirebase._internal();

  // Your API methods go here
}
