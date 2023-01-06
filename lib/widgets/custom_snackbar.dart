import 'package:flutter/material.dart';

void showCustomSnackBar(context, String message, {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message'),
      ),
    );
  }
}
