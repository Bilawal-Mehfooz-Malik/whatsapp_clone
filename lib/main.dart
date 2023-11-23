import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/utils/responsive_layout.dart';
import 'package:whatsapp_clone/screens/web_layout_screen.dart';
import 'package:whatsapp_clone/screens/mobile_layout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: textColor,
        ),
      ),
      home: const ResponsiveLayout(
        webScreenLayout: WebLayoutScreen(),
        mobileScreenLayout: MobileLayoutScreen(),
      ),
    );
  }
}