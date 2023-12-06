import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // elevation: 1,
          backgroundColor: lightMode ? lightTabColor : appBarColor,
          centerTitle: false,
          title: const Text(
            'WhatsApp',
            style: TextStyle(color: whiteColor),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: whiteColor),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: whiteColor),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            indicatorWeight: 3,
            labelColor: lightMode ? whiteColor : tabColor,
            indicatorColor: lightMode ? whiteColor : tabColor,
            unselectedLabelColor: greyColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'Chats',
              ),
              Tab(
                text: 'Status',
              ),
              Tab(
                text: 'Calls',
              ),
            ],
          ),
        ),
        body: const ContactsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: lightMode ? lightTabColor : tabColor,
          child: Icon(
            Icons.comment,
            color: lightMode ? whiteColor : blackColor,
          ),
        ),
      ),
    );
  }
}
