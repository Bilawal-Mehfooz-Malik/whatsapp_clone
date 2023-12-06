import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/info.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/screens/mobile_chat_screen.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MobileChatScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    title: Text(
                      info[index]['name'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      info[index]['message'].toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        info[index]['profilePic'].toString(),
                      ),
                      radius: 30,
                    ),
                    trailing: Text(
                      info[index]['time'].toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(221, 30, 30, 30),
                      ),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
