import 'package:flutter/material.dart';

class LoginColors {
  static const background = Color(0xFF181426);
  static const inputBackground = Color(0xFF2D2540);
  static const inputText = Color(0xFFA89CC8);
  static const button = Color(0xFF4B1EFF);
  static const buttonText = Colors.white;
  static const title = Colors.white;
}

class LoginTextStyles {
  static const title = TextStyle(
    color: LoginColors.title,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );
  static const input = TextStyle(
    color: LoginColors.inputText,
    fontSize: 18,
  );
  static const button = TextStyle(
    color: LoginColors.buttonText,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
} 