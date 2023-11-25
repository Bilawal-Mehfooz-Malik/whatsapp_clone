import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/widgets/privacy_policy_text.dart';
import 'package:whatsapp_clone/shared_features/custom_button.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            // Title
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),

            // Image circular in centre
            Image.asset(
              'assets/images/bg.png',
              height: 340,
              width: 340,
              color: tabColor,
            ),
            const Spacer(),

            // Privacy Policy text
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: PrivacyPolicyText(),
            ),
            const SizedBox(height: 10),

            // Agree & Continue button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                text: 'Agree and continue',
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
