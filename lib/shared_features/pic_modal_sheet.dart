import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

class CustomCircularAvator extends StatelessWidget {
  const CustomCircularAvator({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: lightMode
                    ? const Color.fromARGB(255, 206, 206, 206)
                    : const Color.fromARGB(95, 105, 104, 104)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(icon, size: 35, color: tabColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}
