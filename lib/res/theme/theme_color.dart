import 'package:flutter/material.dart';

// convenience
AppColor appColors() => const AppColor.getColor();

class AppColor {
  final Color primaryActive;
  final Color primaryActiveLight;
  final Color primaryInactive;
  final Color primaryInactiveLight;
  final Color warning;
  final Color error;
  final Color linked;
  final Color fb;
  final Color twiter;
  final Color blueColor;
  final Color themeDartGreen;
  final Color greenColors1;
  final Color loginGradientStart;
  final Color loginGradientEnd;
  final Color textColor;
  final Color commonBackgroundColor;

  const AppColor({
    required this.themeDartGreen,
    required this.warning,
    required this.error,
    required this.linked,
    required this.twiter,
    required this.fb,
    required this.primaryActive,
    required this.primaryActiveLight,
    required this.primaryInactive,
    required this.primaryInactiveLight,
    required this.blueColor,
    required this.greenColors1,
    required this.loginGradientStart,
    required this.loginGradientEnd,
    required this.textColor,
    required this.commonBackgroundColor
  });

  const AppColor.getColor()
      : primaryActive = Colors.black,
        primaryActiveLight = Colors.lightBlueAccent,
        primaryInactive = Colors.blueGrey,
        primaryInactiveLight = Colors.grey,
        warning = const Color(0xFFC97100),
        error = const Color(0xFFFC3D0B),
        fb = const Color(0xFF4267B2),
        linked = const Color(0xFF0077B7),
        twiter = const Color(0xFF55ACEE),
        blueColor = const Color.fromRGBO(20, 118, 252, 1),
        themeDartGreen = const Color(0xFF2e7d32),
        greenColors1 = const Color(0xFF4CAF50),
        loginGradientStart = const  Color(0xFFfd6a15),
        loginGradientEnd = const  Color(0XFF65739d),
        textColor = const  Color(0XFF012c47),
        commonBackgroundColor = const  Color(0xfff6f6ff);

//        lightGrey = const Color.fromRGBO(245, 245, 245, 1),
}
