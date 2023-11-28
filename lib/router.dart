import 'package:flutter/material.dart';
import 'package:whatsapp_clone/shared_features/error_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case UserInfromationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInfromationScreen(),
      );
    case OtpScreen.routeName:
      if (settings.arguments != null &&
          settings.arguments is Map<String, dynamic>) {
        final args = settings.arguments as Map<String, dynamic>;
        final phoneNumber = args['phoneNumber'];
        final verificationId = args['verificationId'];

        if (phoneNumber != null && verificationId != null) {
          return MaterialPageRoute(
            builder: (context) => OtpScreen(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            ),
          );
        }
      }
      return MaterialPageRoute(
        builder: (context) =>
            const ErrorScreen(error: 'Invalid arguments for OTP screen.'),
      );

    default:
      return MaterialPageRoute(
        builder: (context) =>
            const ErrorScreen(error: 'This page doesn\'t exist.'),
      );
  }
}
