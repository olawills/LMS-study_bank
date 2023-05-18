import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static final Dialogs _dialogs = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs() {
    return _dialogs;
  }

  static Widget questionDialog({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hi....',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Please login before you start')
        ],
      ),
      actions: [
        TextButton(
          onPressed: onTap,
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  static Widget logutDialog({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [Text('Are you sure u want to logout..')],
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('No'),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
