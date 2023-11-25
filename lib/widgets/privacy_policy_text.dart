import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

class PrivacyPolicyText extends StatelessWidget {
  const PrivacyPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(color: greyColor),
        children: <TextSpan>[
          TextSpan(text: 'Read our'),
          TextSpan(
            text: ' Privacy and Policy',
            style: TextStyle(color: blueColor),
          ),
          TextSpan(text: '. Tap "Agree and Continue" to accept the '),
          TextSpan(
            text: 'Terms of Serivice',
            style: TextStyle(color: blueColor),
          ),
          TextSpan(text: '.'),
        ],
      ),
    );
  }
}
