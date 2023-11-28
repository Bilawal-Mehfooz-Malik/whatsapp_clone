import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';

import 'widgets/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/router.dart';
import 'package:whatsapp_clone/data/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/modules/responsive_layout.dart';
import 'package:whatsapp_clone/screens/web_layout_screen.dart';
import 'package:whatsapp_clone/features/startup/screens/startup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const ResponsiveLayout(
        webScreenLayout: WebLayoutScreen(),
        mobileScreenLayout: StartUpScreen(),
      ),
    );
  }
}
