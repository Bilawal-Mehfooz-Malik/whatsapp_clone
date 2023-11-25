import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:whatsapp_clone/shared_features/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Text('Enter your phone number'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top text
              const Text('WhatsApp will need to verify you account.'),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  children: [
                    // Select Country Button
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          alignment: Alignment.center,
                          child: const Text(
                            'Choose a country',
                            style: TextStyle(color: whiteColor),
                          ),
                          onTap: () {},
                        ),
                      ],
                      onChanged: null,
                      isExpanded: true,
                      dropdownColor: tabColor,
                      iconEnabledColor: tabColor,
                      iconDisabledColor: tabColor,
                      style: const TextStyle(color: whiteColor),
                      underline: Container(height: 2, color: tabColor),
                    ),

                    // Country code and Phone number field
                    const Row(
                      children: [
                        // Country code input field
                        SizedBox(
                          width: 80,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: '+',
                            ),
                          ),
                        ),
                        SizedBox(width: 8),

                        // Phone number field
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Phone number'),
                          ),
                        )
                      ],
                    ),

                    // Carrier charges Text
                    const SizedBox(height: 16),
                    const Text(
                      'Carrier charges may apply',
                      style: TextStyle(color: greyColor),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: CustomButton(text: 'Next', onPressed: () {}),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
