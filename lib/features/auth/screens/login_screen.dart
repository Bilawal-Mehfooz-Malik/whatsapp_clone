import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/shared_features/custom_button.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/shared_features/error_messages_structure.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  Country? countryDetails;
  final countryCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
  }

  // Borders for text fields
  final border = const UnderlineInputBorder(
    borderSide: BorderSide(color: tabColor),
  );

  final focusedBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: tabColor, width: 2),
  );

  // pick country button method
  void pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          countryDetails = country;
          countryCodeController.text = country.phoneCode;
        });
      },
    );
  }

  // send phone number method attached to next button
  void sendPhoneNumber() async {
    String phoneNumber = phoneNumberController.text.trim();

    if (countryDetails == null || phoneNumber.isEmpty) {
      showErrorDialog(
        context: context,
        content: 'Invalid country or phone number.',
      );
      return;
    }
    ref
        .read(authControllerProvider)
        .signInWithPhone(context, '+${countryDetails!.phoneCode}$phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = lightTheme ? lightTabColor : tabColor;
    final bgColor = lightTheme ? whiteColor : backgroundColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: bgColor,
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
                    InkWell(
                      onTap: pickCountry,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          enabledBorder: border,
                          focusedBorder: focusedBorder,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Spacer(),
                            Text(
                              countryDetails != null
                                  ? countryDetails!.name
                                  : 'Choose a country',
                            ),
                            const Spacer(),
                            Icon(Icons.arrow_drop_down, color: textColor),
                          ],
                        ),
                      ),
                    ),

                    // Country code and Phone number field
                    Row(
                      children: [
                        // Country code input field
                        SizedBox(
                          width: 80,
                          child: TextField(
                            readOnly: true,
                            cursorColor: textColor,
                            textAlign: TextAlign.center,
                            controller: countryCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: '+',
                              enabledBorder: border,
                              focusedBorder: border,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Phone number field
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: border,
                              hintText: 'Phone number',
                              focusedBorder: focusedBorder,
                            ),
                            cursorColor: textColor,
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),

                    // Carrier charges Text
                    const SizedBox(height: 16),
                    Text(
                      'Carrier charges may apply',
                      style: TextStyle(
                        color: lightTheme ? lightGreyColor : greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: CustomButton(
                  text: 'Next',
                  onPressed: sendPhoneNumber,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
