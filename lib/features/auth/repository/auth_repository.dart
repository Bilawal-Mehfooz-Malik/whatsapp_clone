import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/modules/user_model.dart';
import 'package:whatsapp_clone/screens/mobile_layout_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/shared_features/error_messages_structure.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone/shared_features/repositories/common_firebase_storage_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class AuthRepository {
  AuthRepository({required this.auth, required this.firestore});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<UserModel?> getCurrentUserData() async {
    final userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  // Sign in with phone method for Login Screen upon pressing next button
  void signInWithPhone(String phoneNumber, BuildContext context) async {
    showCircularDialog(context: context, text: 'Connecting...');
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Navigator.of(context).pop();
          showErrorDialog(context: context, content: e.message!);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return OtpScreen(
                  phoneNumber: phoneNumber,
                  verificationId: verificationId,
                );
              },
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(context: context, content: e.message!);
      }
    }
  }

  //follow up method for verifying otp for otp screen upon pressing next button
  void verifyOtp({
    required String userOtp,
    required BuildContext context,
    required String verificationId,
  }) async {
    try {
      showCircularDialog(context: context, text: 'Verifying...');

      final credential = PhoneAuthProvider.credential(
        smsCode: userOtp,
        verificationId: verificationId,
      );

      await auth.signInWithCredential(credential);

      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const UserInfromationScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        showErrorDialog(
          context: context,
          content: e.message!,
        );
      }
    }
  }

  // Follow up method for upon pressing next button in user information screen
  //this method is called for saving data to firebase firestore.
  void saveUserDataToFirebase({
    required String name,
    required ProviderRef ref,
    required File? profilePic,
    required BuildContext context,
  }) async {
    try {
      showCircularDialog(context: context, text: 'Creating profile...');
      String? photoUrl;
      String uid = auth.currentUser!.uid;

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('profilePic/$uid', profilePic);

        var user = UserModel(
          uid: uid,
          name: name,
          isOnline: true,
          profilePic: photoUrl,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: [],
        );

        await firestore.collection('users').doc(uid).set(user.toMap());
      }

      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
          return const MobileLayoutScreen();
        }), (route) => false);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        showErrorDialog(context: context, content: e.toString());
      }
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }
}
