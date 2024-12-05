import 'package:flutter/material.dart';

class AppTextStyle {

  static TextStyle headerTextStyle({Color color = Colors.black,double fontSize = 20 }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle normalTextStyle(
      {Color color = Colors.black, double fontSize = 14}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      height: 1.5,
    );
  }
}
