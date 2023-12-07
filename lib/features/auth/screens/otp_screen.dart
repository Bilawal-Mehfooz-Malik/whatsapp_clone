import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  final String phoneNumber;
  final String verificationId;

  void verifyOtp(WidgetRef ref, BuildContext context, String otp) {
    ref.read(authControllerProvider).verifyOtp(
          context,
          verificationId,
          otp,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = lightTheme ? lightTabColor : tabColor;
    final bgColor = lightTheme ? whiteColor : backgroundColor;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: bgColor,
          foregroundColor: textColor,
          title: Text('Verify $phoneNumber'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text('We have sent an SMS with a code.'),

              // Otp input field
              SizedBox(
                width: size.width * 0.35,
                child: TextField(
                  cursorColor: textColor,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: '- - - - - -',
                    hintStyle: TextStyle(fontSize: 30),
                  ),
                  onChanged: (val) {
                    if (val.length == 6) {
                      verifyOtp(ref, context, val.trim());
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('Enter a 6-digit code'),
            ],
          ),
        ),
      ),
    );
  }
}
