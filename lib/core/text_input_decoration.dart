import 'package:flutter/material.dart';

const textInputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.15,
      color: Color(0xff4d4d4d),
      fontWeight: FontWeight.w400),
  labelStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.15,
      color: Color(0xff4d4d4d),
      fontWeight: FontWeight.w400),
  suffixIconColor: Color.fromRGBO(0, 0, 0, 0.54),
  errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(246, 17, 17, 1))),
);
