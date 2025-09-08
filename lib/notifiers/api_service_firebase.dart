import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/model/education_history_model.dart';
import 'package:my_profile/model/profile_model.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/model/product_model.dart';

class ApiServiceFirebase extends ChangeNotifier {
  static ApiServiceFirebase? _instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static ApiServiceFirebase get instance {
    _instance ??= ApiServiceFirebase._internal();
    return _instance!;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  ProfileModel profileModel = ProfileModel.empty();
  List<ProductModel> products = [];
  List<EducationHistoryModel> educationHistory = [];

  ApiServiceFirebase._internal();

  // Your API methods go here
  Future<void> getData() async {
    // Implement your API call here
    try {
      final data =
          await firebaseFirestore
              .collection(AppConstant.collectionIdEducationHistory)
              .get();
      if (data.docs.isNotEmpty) {
        final list =
            data.docs.map<ProfileModel>((doc) {
              var map = doc.data();
              map["\$id"] = doc.id;
              return ProfileModel.fromJson(map);
            }).toList();
        profileModel = list[0];
      }
      profileModel;
      notifyListeners();
    } catch (e) {
      ProfileModel.empty();
    }
  }

  Future<void> getProducts() async {
    // Implement your API call here
    try {
      final data =
          await firebaseFirestore
              .collection(AppConstant.collectionIdProducts)
              .get();
      if (data.docs.isNotEmpty) {
        final list =
            data.docs.map<ProductModel>((doc) {
              var map = doc.data();
              map["\$id"] = doc.id;
              return ProductModel.fromJson(map);
            }).toList();
        list;
        products.addAll(list);
      }
      notifyListeners();
    } catch (e) {
      products = [];
    }
  }

  Future<void> getEducationHistory() async {
    // Implement your API call here
    try {
      final data =
          await firebaseFirestore
              .collection(AppConstant.collectionIdEducationHistory)
              .get();
      if (data.docs.isNotEmpty) {
        final list =
            data.docs.map<EducationHistoryModel>((doc) {
              var map = doc.data();
              map["\$id"] = doc.id;
              return EducationHistoryModel.fromMap(map);
            }).toList();
        educationHistory.addAll(list);
      }
      notifyListeners();
    } catch (e) {
      educationHistory = [];
    }
  }
}
