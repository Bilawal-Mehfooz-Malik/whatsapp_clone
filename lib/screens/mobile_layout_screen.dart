import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/select_contacts/screens/select_contacts_screen.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;
    final gwColor = lightMode ? whiteColor : tabColor;
    final wbColor = lightMode ? whiteColor : blackColor;

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // AppBar
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                elevation: 1,
                centerTitle: false,
                scrolledUnderElevation: 1,
                foregroundColor: whiteColor,
                backgroundColor: lightMode ? lightTabColor : appBarColor,
                title:
                    const Text('WhatsApp', style: TextStyle(color: whiteColor)),
                actions: [
                  //Search Icon
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),

                  // Options icon
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],

                //Tab Bar
                bottom: TabBar(
                  indicatorWeight: 3,
                  labelColor: gwColor,
                  indicatorColor: gwColor,
                  unselectedLabelColor: greyColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'Chats'),
                    Tab(text: 'Updates'),
                    Tab(text: 'Calls'),
                  ],
                ),
              ),
            ];
          },

          // contact List
          body: const ContactsList(),
        ),

        //Floating Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const SelectContactsScreen()));
          },
          backgroundColor: gwColor,
          child: Icon(Icons.comment, color: wbColor),
        ),
      ),
    );
  }
}
