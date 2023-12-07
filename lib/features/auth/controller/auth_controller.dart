import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_clone/modules/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  final AuthRepository authRepository;
  final ProviderRef ref;

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(phoneNumber, context);
  }

  //verifying otp method for otp screen upon pressing next button
  void verifyOtp(BuildContext context, String verificationId, String otp) {
    authRepository.verifyOtp(
      userOtp: otp,
      context: context,
      verificationId: verificationId,
    );
  }

  // upon pressing next button in user information screen 
  //this method is called for saving data to firebase firestore.
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
