import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);

  static const Color primaryColor = Color(0xFF2633C5);
  static const Color secondaryColor = Color(0xfffea41d);
  static const Color dangerColor = Color(0xFFE85050);
  static const Color successColor = Color.fromARGB(255, 70, 187, 75);

  static const String fontName = 'Roboto';

  static const TextStyle headerLg = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: nearlyWhite,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: nearlyWhite,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: nearlyWhite,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: nearlyWhite,
  );

  static const TextStyle bodyPrimary = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.05,
    color: primaryColor,
  );
  static const TextStyle bodyPrimaryLg = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 32,
    letterSpacing: -0.05,
    color: primaryColor,
  );
  static const TextStyle bodySecondary = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.05,
    color: secondaryColor,
  );
  static const TextStyle bodySecondaryLg = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 32,
    letterSpacing: -0.05,
    color: secondaryColor,
  );
  static const TextStyle bodyBlack = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );
  static const TextStyle bodyBlackMd = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText,
  );

  static const defaultPadding = 16.0;
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
