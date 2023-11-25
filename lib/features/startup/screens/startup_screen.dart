import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/widgets/privacy_policy_text.dart';
import 'package:whatsapp_clone/shared_features/custom_button.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),

            // Image circular in centre
            Image.asset(
              'assets/images/bg.png',
              height: 340,
              width: 340,
              color: tabColor,
            ),
            const SizedBox(height: 50),

            // Title
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Privacy Policy text
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: PrivacyPolicyText(),
            ),
            const Spacer(flex: 2),

            // Agree & Continue button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                text: 'Agree and continue',
                onPressed: () {
                  navigateToLoginScreen(context);
                },
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
