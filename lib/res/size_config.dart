import 'package:flutter/cupertino.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _blockWidth = 0;
  static double? _blocHeight = 0;
  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static double? fontConstant;
  static double? screenHeightConstant;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = (_screenWidth! / 100);
    _blocHeight = _screenHeight! / 100;

    textMultiplier = _blocHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blocHeight;
    widthMultiplier = _blockWidth;

    screenHeightConstant = (_screenWidth!* 0.031);
    fontConstant = (screenHeightConstant! / 12.5);



    print(SizeConfig.screenHeightConstant);
  }
}

