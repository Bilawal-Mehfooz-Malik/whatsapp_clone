import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

class PrivacyPolicyText extends StatelessWidget {
  const PrivacyPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = lightTheme ? lightGreyColor : greyColor;
    final textLinkColor = lightTheme ? lightBlueColor : blueColor;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: textColor),
        children: <TextSpan>[
          const TextSpan(text: 'Read our'),
          TextSpan(
            text: ' Privacy and Policy',
            style: TextStyle(color: textLinkColor),
          ),
          const TextSpan(text: '. Tap "Agree and Continue" to accept the '),
          TextSpan(
            text: 'Terms of Serivice',
            style: TextStyle(color: textLinkColor),
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
