import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle standard () {
    return const TextStyle();
  }

  static TextStyle cardHeader() {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  }

  static TextStyle cardSubHeader() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
  }

  static TextStyle cardText() {
    return const TextStyle(color: Colors.white);
  }

  static TextStyle cardTextBlack() {
    return const TextStyle(color: Colors.black);
  }

  static TextStyle cardTextBold() {
    return const TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  }

}