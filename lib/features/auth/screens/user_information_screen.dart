import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatsapp_clone/shared_features/image_picker.dart';
import 'package:whatsapp_clone/shared_features/custom_button.dart';
import 'package:whatsapp_clone/shared_features/pic_modal_sheet.dart';
import 'package:whatsapp_clone/shared_features/error_messages_structure.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class UserInfromationScreen extends ConsumerStatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  ConsumerState<UserInfromationScreen> createState() =>
      _UserInfromationScreenState();
}

class _UserInfromationScreenState extends ConsumerState<UserInfromationScreen> {
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
      if (_showEmoji) {
        FocusScope.of(context).unfocus();
      }
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

  // Upon tapping icon camera it open this bottom sheet
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
                maxHeight: MediaQuery.of(context).size.height - 650),
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

  //saving data to firestore
  void _storeUserData() async {
    final name = _nameController.text.trim();
    FocusScope.of(context).unfocus();
    if (name.isEmpty) {
      showErrorDialog(
          context: context, content: 'Please enter a valid username.');
    }

    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(name, _image, context);
    }
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
                      bottom: 8,
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

                    // emoji icon
                    IconButton(
                      onPressed: _toggleEmoji,
                      icon: const Icon(Icons.emoji_emotions_outlined),
                    ),
                  ],
                ),
                _showEmoji ? const SizedBox(height: 40) : const Spacer(),

                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 145,
                  ),
                  child: CustomButton(text: 'Next', onPressed: _storeUserData),
                ),
                _showEmoji
                    ? Expanded(
                        child: EmojiPicker(
                          textEditingController: _nameController,
                          config: Config(
                            columns: 8,
                            indicatorColor: tabColor,
                            iconColorSelected: tabColor,
                            bgColor: lightMode ? whiteColor : backgroundColor,
                          ),
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
