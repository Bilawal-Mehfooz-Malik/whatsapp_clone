import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/modules/user_model.dart';
import 'package:whatsapp_clone/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp_clone/shared_features/error_messages_structure.dart';

final selectContactRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  SelectContactRepository({
    required this.firestore,
  });
  final FirebaseFirestore firestore;

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      bool isFound = false;
      final userCollection = await firestore.collection('users').get();

      for (var document in userCollection.docs) {
        final userData = UserModel.fromMap(document.data());
        String selectedContactPhoneNum =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedContactPhoneNum == userData.phoneNumber) {
          isFound = true;
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => MobileChatScreen(
                  name: userData.name,
                  uid: userData.uid,
                ),
              ),
            );
          }
        }
        if (!isFound) {
          if (context.mounted) {
            showSnack(
                context: context,
                content: 'This number does not exist on this app.');
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(context: context, content: e.toString());
      }
    }
  }
}
