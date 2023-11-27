import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

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
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero)),
        );
      });
}
