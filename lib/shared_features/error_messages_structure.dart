import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

const border =
    BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.zero));

void showSnack({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

void showErrorDialog({required BuildContext context, required String content}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: tabColor)),
            ),
          ],
          shape: border,
        );
      });
}

void showCircularDialog({required BuildContext context, required String text}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        shape: border,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Row(
            children: [
              const CircularProgressIndicator(color: tabColor),
              const SizedBox(width: 16),
              Text(text),
            ],
          ),
        ),
      );
    },
  );
}
