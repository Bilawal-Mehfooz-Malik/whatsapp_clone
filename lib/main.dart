import 'widgets/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/shared_features/loader.dart';
import 'package:whatsapp_clone/screens/mobile_layout_screen.dart';
import 'package:whatsapp_clone/shared_features/error_screen.dart';
import 'package:whatsapp_clone/features/startup/screens/startup_screen.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const StartUpScreen();
              }
              return const MobileLayoutScreen();
            },
            error: (err, trace) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
