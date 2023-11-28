import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  AuthController({required this.authRepository});

  final AuthRepository authRepository;

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(phoneNumber, context);
  }

  void verifyOtp(BuildContext context, String verificationId, String otp) {
    authRepository.verifyOtp(
      userOtp: otp,
      context: context,
      verificationId: verificationId,
    );
  }
}
