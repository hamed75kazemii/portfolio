import 'package:flutter/material.dart';
import 'package:hamed_portfolio/method/calculate_responsive.dart';

class AppTextStyles {
  // Set this to your base screen width
  // Font Weight
  static bool ntsb = needToSetBig();
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight regular = FontWeight.w400;

  // Display Styles (used for very large text, like banners or major headers)
  static TextStyle displayXXXLarge(
      {Color color = Colors.black, FontWeight weight = FontWeight.w600}) {
    return TextStyle(fontSize: 40, color: color, fontWeight: weight);
  }

  static TextStyle displayXXLarge(
      {Color color = Colors.black, FontWeight weight = FontWeight.w600}) {
    return TextStyle(fontSize: 35, color: color, fontWeight: weight);
  }

  static TextStyle displayXLarge(
      {Color color = Colors.black, FontWeight weight = FontWeight.w600}) {
    return TextStyle(fontSize: 30, color: color, fontWeight: weight);
  }

  static TextStyle displayLarge(
      {Color color = Colors.black, FontWeight weight = FontWeight.w600}) {
    return TextStyle(fontSize: 25, color: color, fontWeight: weight);
  }

  static TextStyle displayMedium(
      {Color color = Colors.black, FontWeight weight = FontWeight.w600}) {
    return TextStyle(fontSize: 20, color: color, fontWeight: weight);
  }

  // Body Styles (used for regular text in paragraphs or descriptions)
  static TextStyle bodyLarge(
      {Color color = Colors.black, FontWeight weight = FontWeight.w400}) {
    return TextStyle(fontSize: 17, color: color, fontWeight: weight);
  }

  static TextStyle bodyMedium(
      {Color color = Colors.black, FontWeight weight = FontWeight.w400}) {
    return TextStyle(fontSize: 15, color: color, fontWeight: weight);
  }

  static TextStyle bodyXMedium(
      {Color color = Colors.black, FontWeight weight = FontWeight.w400}) {
    return TextStyle(fontSize: 13, color: color, fontWeight: weight);
  }

  static TextStyle bodySmall(
      {Color color = Colors.black, FontWeight weight = FontWeight.w400}) {
    return TextStyle(fontSize: 11, color: color, fontWeight: weight);
  }

  // Common Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static const Color red = Colors.red;
}
