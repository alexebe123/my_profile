import 'package:flutter/material.dart';
import 'package:my_profile/firebase_options.dart';
import 'package:my_profile/notifiers/providers.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // مهم جداً
  );
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
