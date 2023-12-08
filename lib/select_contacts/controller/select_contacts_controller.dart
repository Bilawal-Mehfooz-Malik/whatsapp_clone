import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/select_contacts/repository/select_contacts_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return selectContactRepository.getContacts();
});

final selectContactControllerProvider = Provider((ref) {
  final selectcontactRepository = ref.watch(selectContactRepositoryProvider);
  return SelectContactController(
      ref: ref, selectContactRepository: selectcontactRepository);
});

class SelectContactController {
  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  void selectContact(Contact selectedContact, BuildContext context) {
    selectContactRepository.selectContact(selectedContact, context);
  }
}
