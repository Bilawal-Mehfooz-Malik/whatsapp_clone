import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/widgets/chat_list.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';
import 'package:whatsapp_clone/widgets/web_search_bar.dart';
import 'package:whatsapp_clone/widgets/web_chat_appbar.dart';
import 'package:whatsapp_clone/widgets/web_profile_bar.dart';

class WebLayoutScreen extends StatelessWidget {
  const WebLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WebProfileBar(),
                  WebSearchBar(),
                  ContactsList(),
                ],
              ),
            ),
          ),
          Container(
            width: mediaQuery.size.width * 0.75,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: dividerColor),
              ),
              image: DecorationImage(
                image: AssetImage(
                  "assets/backgroundImage.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const ChatAppBar(),
                const SizedBox(height: 20),
                const Expanded(
                  child: ChatList(),
                ),
                Container(
                  height: mediaQuery.size.height * 0.07,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: dividerColor),
                    ),
                    color: chatBarMessage,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          color: greyColor,
                          Icons.emoji_emotions_outlined,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          color: greyColor,
                          Icons.attach_file,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 15,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: searchBarColor,
                              hintText: 'Type a message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 20),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
