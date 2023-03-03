import 'package:flutter/material.dart';

snackBarMessage(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(fontSize: 18, color: Color(0xffffffff)),
    ),
    backgroundColor: const Color(0xff075d8c),
  ));
}
