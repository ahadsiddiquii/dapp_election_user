import 'package:flutter/material.dart';

SnackBar showSnackbar(String text) {
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
    ),
    duration: const Duration(milliseconds: 3000),
    behavior: SnackBarBehavior.floating,
  );
}
