import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/model/contact_us_model.dart';
import 'package:my_profile/model/education_history_model.dart';
import 'package:my_profile/model/experience_history_model.dart';
import 'package:my_profile/model/profile_model.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiServiceFirebase extends ChangeNotifier {
  static ApiServiceFirebase? _instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static ApiServiceFirebase get instance {
    _instance ??= ApiServiceFirebase._internal();
    return _instance!;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  ProfileModel profileModel = ProfileModel.empty();
  List<ProjectModel> projects = [];
  List<EducationHistoryModel> educationHistory = [];
  List<ExperienceHistoryModel> experienceHistory = [];

  ApiServiceFirebase._internal();

  // Your API methods go here
  Future<void> getUsersData() async {
    // Implement your API call here
    profileModel = ProfileModel.empty();
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

  Future<void> getProducts() async {
    // Implement your API call here
    projects.clear();
    try {
      final data =
          await firebaseFirestore
              .collection(AppConstant.collectionIdProducts)
              .get();
      if (data.docs.isNotEmpty) {
        final list =
            data.docs.map<ProjectModel>((doc) {
              var map = doc.data();
              map["\$id"] = doc.id;
              return ProjectModel.fromJson(map);
            }).toList();
        list;
        projects.addAll(list);
      }
      notifyListeners();
    } catch (e) {
      projects = [];
    }
  }

  Future<void> getEducationHistory() async {
    // Implement your API call here
    educationHistory.clear();
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

  Future<void> gtetExperienceHistory() async {
    // Implement your API call here
    experienceHistory.clear();
    try {
      final data =
          await firebaseFirestore
              .collection(AppConstant.collectionIdExperienceHistory)
              .get();
      if (data.docs.isNotEmpty) {
        final list =
            data.docs.map<ExperienceHistoryModel>((doc) {
              var map = doc.data();
              map["\$id"] = doc.id;
              return ExperienceHistoryModel.fromJson(map);
            }).toList();
        experienceHistory.addAll(list);
      }
      notifyListeners();
    } catch (e) {
      experienceHistory = [];
    }
  }

  Future<void> addContact(ContactUsModel contactUsModel) async {
    // Implement your API call here
    try {
      await firebaseFirestore
          .collection(AppConstant.collectionIdContactUs)
          .add(contactUsModel.toJson());
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addProject(ProjectModel project) async {
    try {
      await firebaseFirestore
          .collection(AppConstant.collectionIdProducts)
          .add(project.toJson());
      projects.add(project);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> uploadPhoto(Uint8List bytes) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    try {
      await Supabase.instance.client.storage
          .from('images')
          .uploadBinary(fileName, bytes);

      final publicUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print('Upload error: $e');
      return "";
    }
  }

  Future<void> updateProject(ProjectModel project) async {
    try {
      await firebaseFirestore
          .collection(AppConstant.collectionIdProducts)
          .doc(project.id)
          .update(project.toJson());
      projects.removeWhere((p) => p.id == project.id);
      projects.add(project);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addEducationHistory(
    EducationHistoryModel educationHistoryModel,
  ) async {
    try {
      await firebaseFirestore
          .collection(AppConstant.collectionIdEducationHistory)
          .add(educationHistoryModel.toJson());
      educationHistory.add(educationHistoryModel);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateEducationHistory(
    EducationHistoryModel educationHistoryModel,
  ) async {
    try {
      await firebaseFirestore
          .collection(AppConstant.collectionIdEducationHistory)
          .doc(educationHistoryModel.id)
          .update(educationHistoryModel.toJson());
      educationHistory.removeWhere((p) => p.id == educationHistoryModel.id);
      educationHistory.add(educationHistoryModel);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteEducationHistory(String id) async {
    try {
      await firebaseFirestore
          .collection(AppConstant.collectionIdEducationHistory)
          .doc(id)
          .delete();
      educationHistory.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteProjectHistory(String id) async {
    try {
      await firebaseFirestore
          .collection(AppConstant.collectionIdProducts)
          .doc(id)
          .delete();
      projects.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
