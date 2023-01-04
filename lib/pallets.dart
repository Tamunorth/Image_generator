import 'dart:ui';

import 'package:flutter/material.dart';

class Pallets {
  static const grey35 = Color(0xff595959);
  static const chatGreen = Color(0xffC1F9DC);
  static const chatBlue = Color(0xffD4E7F9);
  static const white = Color(0xffffffff);
  static const primary = Color(0xff1976D2);
  static const primary1 = Color(0xff09447F);
  static const primaryTint = Color(0xffC3DDF7);
  static const secondary = Color(0xff08B059);
  static const secondary1 = Color(0xff5DAE1C);
  static const tertiary = Color(0xffD0AF04);
  static const tertiary2 = Color(0xffD7083A);
  static const tertiaryShade = Color(0xffB4052F);
  static const error = Color(0xffC70606);
  static const grey100 = Color(0xffffffff);
  static const grey95 = Color(0xffF2F2F2);
  static const grey90 = Color(0xffE6E6E6);
  static const grey85 = Color(0xffD9D9D9);
  static const grey75 = Color(0xffBFBFBF);
  static const grey50 = Color(0xff808080);
  static const grey25 = Color(0xff414141);
  static const grey0 = Color(0xff040707);
  static const highlightYellow = Color(0xffE9C610);
  static const red = Color(0xffF82356);
  static const facebookBlue = Color(0xff1877F2);

  static const MaterialColor kToDark = MaterialColor(
    0xff09447f,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff083d72), //10%
      100: Color(0xff073666), //20%
      200: Color(0xff063059), //30%
      300: Color(0xff05294c), //40%
      400: Color(0xff052240), //50%
      500: Color(0xff041b33), //60%
      600: Color(0xff031426), //70%
      700: Color(0xff020e19), //80%
      800: Color(0xff01070d), //90%
      900: Color(0xff000000), //100%
    },
  );
  static const MaterialColor kToLight = MaterialColor(
    0xff09447f,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff22578c), //10%
      100: Color(0xff3a6999), //20%
      200: Color(0xff537ca5), //30%
      300: Color(0xff6b8fb2), //40%
      400: Color(0xff84a2bf), //50%
      500: Color(0xff9db4cc), //60%
      600: Color(0xffb5c7d9), //70%
      700: Color(0xffcedae5), //80%
      800: Color(0xffe6ecf2), //90%
      900: Color(0xffffffff), //100%
    },
  );
}
