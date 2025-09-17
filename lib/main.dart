import 'package:flutter/material.dart';
import 'package:my_profile/firebase_options.dart';
import 'package:my_profile/notifiers/providers.dart';
import 'package:my_profile/screen/dashbord/dashbord_screen.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // مهم جداً
  );
  await Supabase.initialize(
    url: 'https://bpcfdupkxxalmryqdkym.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwY2ZkdXBreHhhbG1yeXFka3ltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4MTc4MjYsImV4cCI6MjA3MTM5MzgyNn0.vH_iCWdNQ_KC-nHPhhYbX15PgFek8D_JghWojvTidL4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
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
    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0F1418),
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'monospace'),
        ),
        routerConfig: router,
      ),
    );
  }
}
