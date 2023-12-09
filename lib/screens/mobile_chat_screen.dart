import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/modules/user_model.dart';
import 'package:whatsapp_clone/shared_features/loader.dart';
import 'package:whatsapp_clone/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerStatefulWidget {
  const MobileChatScreen({
    super.key,
    required this.name,
    required this.uid,
  });

  final String name;
  final String uid;

  @override
  ConsumerState<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends ConsumerState<MobileChatScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: whiteColor,
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userDataById(widget.uid),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name),
                  Text(
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 13),
                    snapshot.data!.isOnline ? 'online' : 'offline',
                  ),
                ],
              );
            }),
        actions: [
          IconButton(
            // VideoCall Icon
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),

          // Call Icon
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),

          // Options Icon
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          //Chat List containing all messages
          const Expanded(child: ChatList()),

          Row(
            children: [
              //Message Sending Text Field
              Expanded(
                child: TextField(
                  style: const TextStyle(color: whiteColor),
                  controller: _messageController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: appBarColor,

                    //emoji Icon
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.emoji_emotions,
                        color: messageIconColor,
                      ),
                    ),

                    suffixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // attach file icon
                          Icon(
                            Icons.attach_file,
                            color: messageIconColor,
                          ),
                          SizedBox(width: 12),

                          // camera icon
                          Icon(
                            Icons.camera_alt,
                            color: messageIconColor,
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: tabColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(Icons.keyboard_voice_rounded),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
