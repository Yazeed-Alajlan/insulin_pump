import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color.fromARGB(255, 230, 230, 230);

  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color whiteText = Color(0xFFFAFAFA);
  static const Color lightText = Color(0xFF4A6572);

  static const Color darkerText = Color(0xFF17262A);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);

  // static const Color spacer = Color(0xFFF2F2F2);

  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color nearlyBlue = Color(0xFF00B6F0);

  static const Color primaryColor = Color(0xFF2633C5);
  static const Color primaryColorLight = Color(0xFF6A88E5);
  static const Color secondaryColor = Color(0xfffea41d);

  // Green
  static Color darkGreenColor = Color(0xFF3ABD6F);
  static Color lightGreenColor = Color(0xFFA1ECBF);

  // Yellow
  static Color darkYellowColor = Color(0xFFffc107);
  static Color lightYellowColor = Color(0xFFFFDA7A);

  static const Color successColor = Color(0xFF3ABD6F);
  static const Color warningColor = Color(0xFFffc107);
  static const Color dangerColor = Color(0xFFdf4759);

  static const BoxDecoration primaryColorGradient = BoxDecoration(
    color: AppTheme.primaryColor,
    gradient: LinearGradient(colors: <Color>[
      primaryColor,
      primaryColorLight,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
  );

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

  static TextStyle bodyWhite({required String size, bool? bold}) {
    return TextStyle(
      fontFamily: fontName,
      color: whiteText,
      fontSize: size == "lg"
          ? 32
          : size == "md"
              ? 24
              : size == "xlg"
                  ? 48
                  : 18,
      fontWeight:
          bold == null || bold == false ? FontWeight.w500 : FontWeight.bold,
    );
  }

  static TextStyle bodyBlack({required String size, bool? bold}) {
    return TextStyle(
      fontFamily: fontName,
      color: darkText,
      fontSize: size == "lg"
          ? 32
          : size == "md"
              ? 24
              : size == "xlg"
                  ? 48
                  : 18,
      fontWeight:
          bold == null || bold == false ? FontWeight.w500 : FontWeight.bold,
      letterSpacing: 1,
    );
  }

  static TextStyle bodyPrimary({required String size, bool? bold}) {
    return TextStyle(
      fontFamily: fontName,
      color: primaryColor,
      fontSize: size == "lg"
          ? 32
          : size == "md"
              ? 24
              : size == "xlg"
                  ? 48
                  : 18,
      fontWeight:
          bold == null || bold == false ? FontWeight.w500 : FontWeight.bold,
      letterSpacing: 1,
    );
  }

  static TextStyle body(
      {required String size, required Color color, bool? bold}) {
    return TextStyle(
      fontFamily: fontName,
      color: color,
      fontSize: size == "lg"
          ? 32
          : size == "md"
              ? 24
              : size == "xlg"
                  ? 48
                  : 18,
      fontWeight:
          bold == null || bold == false ? FontWeight.w500 : FontWeight.bold,
      letterSpacing: 1,
    );
  }

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.5,
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
