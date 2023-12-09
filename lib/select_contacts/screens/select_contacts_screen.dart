import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/shared_features/loader.dart';
import 'package:whatsapp_clone/shared_features/error_screen.dart';
import 'package:whatsapp_clone/select_contacts/controller/select_contacts_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: whiteColor,
        title: const Text('Select contact'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
            data: (contactList) => ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (ctx, index) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(ref, contact, context),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: contact.photo == null
                          ? const CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Color.fromARGB(255, 91, 109, 117),
                              child: Icon(Icons.person,
                                  size: 45, color: greyColor),
                            )
                          : CircleAvatar(
                              radius: 25,
                              backgroundImage: MemoryImage(contact.photo!),
                            ),
                      title: Text(contact.displayName),
                    ),
                  ),
                );
              },
            ),
            error: (err, trace) => ErrorScreen(error: err.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
