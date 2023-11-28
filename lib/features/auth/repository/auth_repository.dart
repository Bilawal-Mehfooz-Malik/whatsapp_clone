import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone/shared_features/error_messages_structure.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class AuthRepository {
  AuthRepository({required this.auth, required this.firestore});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  void signInWithPhone(String phoneNumber, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.pushNamed(context, OtpScreen.routeName, arguments: {
            'phoneNumber': phoneNumber,
            'verificationId': verificationId,
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(context: context, content: e.message!);
      }
    }
  }

  void verifyOtp({
    required String userOtp,
    required BuildContext context,
    required String verificationId,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        smsCode: userOtp,
        verificationId: verificationId,
      );
      await auth.signInWithCredential(credential);
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          UserInfromationScreen.routeName,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showErrorDialog(
          context: context,
          content: e.message!,
        );
      }
    }
  }
}
