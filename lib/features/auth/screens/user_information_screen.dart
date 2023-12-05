import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatsapp_clone/shared_features/image_picker.dart';
import 'package:whatsapp_clone/shared_features/custom_button.dart';
import 'package:whatsapp_clone/shared_features/pic_modal_sheet.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  static const routeName = '/user-information';

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? _image;
  var _showEmoji = false;
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleEmoji() {
    setState(() {
      _showEmoji = !_showEmoji;
    });
  }

//Gallery Image Picker
  void _pickImageFromGallery() async {
    _image = await pickImageFromGallery(context);
    setState(() {});
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

//Camera Image Picker
  void _pickImageFromCamera() async {
    _image = await pickImageFromCamera(context);
    setState(() {});
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _bottomSheetStructure() {
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
                maxHeight: MediaQuery.of(context).size.height - 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile photo',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    InkWell(
                      onTap: _pickImageFromCamera,
                      child: const CustomCircularAvator(
                        text: 'Camera',
                        icon: Icons.camera_alt,
                      ),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: _pickImageFromGallery,
                      child: const CustomCircularAvator(
                        text: 'Gallery',
                        icon: Icons.photo,
                      ),
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
                  'Please provide your name and an optional profile photo.',
                ),
                const SizedBox(height: 24),

                //Profile Image Picker
                Stack(
                  children: [
                    _image == null
                        ? CircleAvatar(
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
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(_image!),
                          ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: _bottomSheetStructure,
                        icon: const Icon(Icons.add_a_photo, color: tabColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                //Name text field
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 25,
                        cursorColor: tabColor,
                        enableSuggestions: true,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Type your name here',
                        ),
                        onTap: () {
                          setState(() {
                            _showEmoji = false;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: _toggleEmoji,
                      icon: const Icon(Icons.emoji_emotions_outlined),
                    ),
                  ],
                ),
                _showEmoji ? const SizedBox(height: 40) : const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 145,
                  ),
                  child: CustomButton(text: 'Next', onPressed: () {}),
                ),
                _showEmoji
                    ? Expanded(
                        child: EmojiPicker(
                          config: Config(
                            columns: 8,
                            indicatorColor: tabColor,
                            iconColorSelected: tabColor,
                            bgColor: lightMode ? whiteColor : backgroundColor,
                          ),
                          textEditingController: _nameController,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
