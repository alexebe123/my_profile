import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/model/profile_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/screen/dashbord/dashbord_screen.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

class AppConstant {
  static const Color sidebarColor = Color(0xFF0B0F12);
  static const Color accentBlue = Color(0xFF5AA7FF);
  static const Color nameYellow = Color(0xFFF2E089);
  static const Color panelColor = Color(0xFF12161A);
  static const Color backgroundColor = Color(0xFF0D1117);
  static const String collectionIdUsers = 'Users';
  static const String collectionIdProducts = 'Product';
  static const String collectionIdEducationHistory = 'EducationHistory';
  static const String collectionIdExperienceHistory = 'ExperienceHistory';
  static const String collectionIdContactUs = 'ContactUs';
  static const String collectionIdSocialMediaLink = 'SocialMediaLink';

  final router = GoRouter(
    redirect: (context, state) {
      final user =
          Provider.of<ApiServiceFirebase>(context, listen: false).profileModel;
      final loggingIn = state.uri.toString() == '/';

      // لو ماشي مسجل دخول
      if (user.email == ProfileModel.empty().email) {
        return loggingIn ? null : '/';
      }

      // لو مسجل و يحاول يروح للـ login
      if (loggingIn) return '/Dashbord';

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/Dashbord',
        builder: (context, state) => const DashboardScreen(),
      ),

      // ⬅️ هنا المسار الديناميكي
      /* GoRoute(
          path: '/product/:id',
          builder: (context, state) {
            final productId = state.params['id']!; // جلب الـ id من الرابط
            return ProductPage(productId: productId);
          },
        ),*/
    ],
  );
}
