import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider = Provider((ref) =>
    CommonFirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

// uploding profile picture to firebase storage
class CommonFirebaseStorageRepository {
  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });
  final FirebaseStorage firebaseStorage;

  Future<String> storeFileToFirebase(String ref, File file) async {
    final uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    final snap = await uploadTask;
    final downloadUrl = snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
