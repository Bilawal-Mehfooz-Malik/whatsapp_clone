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
    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(25),
    );
    const greyColors = Color.fromARGB(255, 114, 114, 114);
    return TextField(
      controller: _messageController,
      decoration: InputDecoration(
        filled: true,
        errorBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        fillColor: appBarColor,

        //emoji Icon
        prefixIcon: const Icon(
          Icons.emoji_emotions,
          color: greyColors,
        ),

        suffixIcon: const SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // attach file icon
              Icon(
                Icons.attach_file,
                color: greyColors,
              ),
              SizedBox(width: 12),

              // camera icon
              Icon(
                Icons.camera_alt,
                color: greyColors,
              ),
              SizedBox(width: 16)
            ],
          ),
        ),
        border: border,
        hintText: 'Message',
        contentPadding: const EdgeInsets.all(10),
        hintStyle: const TextStyle(color: greyColors),
      ),
    );
  }
}
