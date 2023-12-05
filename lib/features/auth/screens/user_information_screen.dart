import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/shared_features/pic_modal_sheet.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  static const routeName = '/user-information';

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addImage() {
    showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 700,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile photo',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    CustomCircularAvator(
                      icon: Icons.camera_alt,
                      text: 'Camera',
                    ),
                    SizedBox(width: 24),
                    CustomCircularAvator(
                      icon: Icons.photo,
                      text: 'Gallery',
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: lightMode ? null : backgroundColor,
          title: const Text('Profile info'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                    'Please provide your name and an optional profile photo.'),
                const SizedBox(height: 24),

                //Profile Image Picker
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: lightMode
                          ? const Color.fromRGBO(235, 232, 232, 1)
                          : const Color.fromARGB(255, 55, 55, 55),
                      radius: 80,
                      child: const SizedBox(
                        child: Icon(
                          Icons.person,
                          size: 120,
                          color: Color.fromARGB(255, 137, 136, 136),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: _addImage,
                        icon: const Icon(Icons.add_a_photo, color: tabColor),
                      ),
                    ),

                    //Name text field
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Type your name here',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.emoji_emotions_outlined),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
