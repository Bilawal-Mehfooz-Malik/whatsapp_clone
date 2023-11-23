import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: false,
          title: const Text('WhatsApp'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            labelColor: tabColor,
            indicatorColor: tabColor,
            unselectedLabelColor: greyColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
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
          backgroundColor: tabColor,
          child: const Icon(
            Icons.comment,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
