import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

class BottomChatField extends StatelessWidget {
  const BottomChatField({
    super.key,
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
    return TextField(
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

        suffixIcon: const SizedBox(
          width: 100,
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
    );
  }
}
