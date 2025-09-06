import 'package:flutter/material.dart';
import 'package:my_profile/screen/dashbord/analyse_screen.dart';
import 'package:my_profile/screen/dashbord/dashbord_screen.dart';
import 'package:my_profile/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1418),
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'monospace'),
      ),
      home: const DashboardScreen(),
    );
  }
}
