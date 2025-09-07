import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/model/profile_model.dart';
import 'package:my_profile/res/app_constant.dart';

class ApiServiceFirebase extends ChangeNotifier {
  static ApiServiceFirebase? _instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static ApiServiceFirebase get instance {
    _instance ??= ApiServiceFirebase._internal();
    return _instance!;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  ProfileModel profileModel = ProfileModel.empty();

  ApiServiceFirebase._internal();

  // Your API methods go here
  Future<void> getData() async {
    // Implement your API call here
    try {
      final data =
          await firebaseFirestore
              .collection(AppConstant.collectionIdUsers)
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
}
