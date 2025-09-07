import 'package:flutter/material.dart';
import 'package:my_profile/notifiers/providers.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0F1418),
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'monospace'),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
