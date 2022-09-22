import 'dart:ui';

import 'package:dinelah/res/theme/theme_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xffE5001C);
  static const Color newprimaryColor = Color(0xffE5001C);
  static const Color primaryColorVariant = Color(0x33394A6C);
  static const Color textColorRed = Color(0xFFE5001C);
  static const Color textColorDarkBLue = Color(0xFF1F2F40);
  static const Color textColorSkyBLue = Color(0xFF4a97cc);
  static const Color colorEditFieldBg = Color(0xFFFEFEFE);
  static const Color colorBackground = Color(0xfffff6f7);
  static const Color textColorYellow = Color(0xFFf7ba03);
  static const Color etBgColor = Color(0xFFF0F0F0);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color primaryLightColor = Color(0x88242424);
  static const Color failRed = Color(0xFFFF0000);
  static AppColor get colors {
    return const AppColor.getColor();
  }

  static const primaryColorMaterial = const MaterialColor(0xFFAAD400, {
    50: const Color(0xffE5001C),
    100: const Color(0xffE5001C),
    200: const Color(0xffE5001C),
    300: const Color(0xffE5001C),
    400: const Color(0xffE5001C),
    500: const Color(0xffE5001C),
    600: const Color(0xffE5001C),
    700: const Color(0xffE5001C),
    800: const Color(0xffE5001C),
    900: const Color(0xffE5001C)
  });
// use MaterialColor: myGreen.shade100,myGreen.shade500 ...
//   myGreen.shade50 // Color === 0xFFAAD401

  static const primaryGradientColor = LinearGradient(
    colors: [
      Color(0xffE5001C),
      Color(0xffE5001C),
    ],
    stops: [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const primaryGradientColorGreen = LinearGradient(
    colors: [
      Color(0xFF4CAF50),
      Color(0xFF4CAF50),
    ],
    stops: [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const primaryGradientColorWhite = LinearGradient(
    colors: [
      Color(0xffffffff),
      Color(0xffffffff),
    ],
    stops: [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const buttonGradientColor = LinearGradient(
    colors: [
      Color(0xffffdc64),
      Color(0xffffdc64),
    ],
    stops: [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
