import 'package:flutter/material.dart';

class ScreenUtil {
  static late double screenWidth;
  static late double screenHeight;
  static late double screenDensity;

  static void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    screenDensity = mediaQueryData.devicePixelRatio;
  }

  static double setWidth(double width) {
    return (width / 375.0) * screenWidth;
  }

  static double setHeight(double height) {
    return (height / 812.0) * screenHeight;
  }

  static double sp(double fontSize) {
    const double fontScaleFactor = 0.4;

    final double scaleFactor = screenWidth / 375.0;

    return (fontSize * scaleFactor * fontScaleFactor * screenDensity);
  }
}
