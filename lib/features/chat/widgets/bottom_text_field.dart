import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    super.key,
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final TextEditingController _messageController;

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool _isSendButton = false;
  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(25),
  );
  @override
  Widget build(BuildContext context) {
    const greyColors = Color.fromARGB(255, 114, 114, 114);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget._messageController,
            onChanged: (val) {
              if (val.isNotEmpty) {
                setState(() {
                  _isSendButton = true;
                });
              } else {
                setState(() {
                  _isSendButton = false;
                });
              }
            },
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
                    SizedBox(width: 16),
                  ],
                ),
              ),
              border: border,
              hintText: 'Message',
              contentPadding: const EdgeInsets.all(10),
              hintStyle: const TextStyle(color: greyColors),
            ),
          ),
        ),
        const SizedBox(width: 4),

        // Voice and send button
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: tabColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            _isSendButton ? Icons.send_rounded : Icons.keyboard_voice_rounded,
          ),
        ),
      ],
    );
  }
}
