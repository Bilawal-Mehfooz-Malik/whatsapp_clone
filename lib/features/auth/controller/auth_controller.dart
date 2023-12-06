import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

class AuthController {
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  final AuthRepository authRepository;
  final ProviderRef ref;

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

  void saveUserDataToFirebase(
    String name,
    File? profilePic,
    BuildContext context,
  ) {
    authRepository.saveUserDataToFirebase(
      ref: ref,
      name: name,
      context: context,
      profilePic: profilePic,
    );
  }
}
