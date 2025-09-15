import 'package:flutter/material.dart';
import 'package:hamed_portfolio/method/calculate_responsive.dart';

class ScreenUtil {
  static Size? screenSize;
  static double? screenWidth;
  static double? screenHeight;
  static EdgeInsets? screenPadding;
  static double? screenBottomSafeArea;
  static double? screenTopSafeArea;

  static void setScreenSize(Size size) {
    screenSize = size;
  }

  static void setScreenBottomSafeArea(double bottomSafeArea) {
    screenBottomSafeArea = bottomSafeArea;
  }

  static void setScreenPadding(EdgeInsets padding) {
    screenPadding = padding;
  }

  static void setScreenTopSafeArea(double topSafeArea) {
    screenTopSafeArea = topSafeArea;
  }

  static double getScreenWidth() {
    if (screenSize == null) {
      throw Exception('Screen Size is not set. Call setScreenSize() first.');
    }
    return screenSize!.width;
  }

  static double getScreenHeight() {
    if (screenSize == null) {
      throw Exception('Screen Size is not set. Call setScreenHeight() first.');
    }
    return screenSize!.height;
  }

  static double getScreenBottomSafeArea() {
    if (screenPadding == null) {
      throw Exception('Screen Padding is not set. ');
    }
    //return screenBottomSafeArea!;
    return 20;
  }

  static double getScreenEdgePadding(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;
    if (isDesktop) {
      return calculateResponsiveFromWidth(30, screenWidth);
    } else {
      return calculateResponsiveFromWidth(16, screenWidth);
    }
  }
}
