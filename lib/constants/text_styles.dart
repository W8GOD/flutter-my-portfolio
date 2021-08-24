import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colours.dart';

import 'fonts.dart';

class TextStyles {
  TextStyles._();

  static TextStyle get logo => TextStyle(
        fontFamily: Fonts.quicksand_bold,
        color: Color(Colours.color_primary_dark),
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      );

  static TextStyle get menu_item => TextStyle(
        fontFamily: Fonts.quicksand_bold,
        fontSize: 12.0,
        letterSpacing: 1.0,
        color: Color(Colours.color_primary_dark),
      );

  static TextStyle get heading => TextStyle(
        fontFamily: Fonts.quicksand_bold,
        color: Color(Colours.color_primary_dark),
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      );

  static TextStyle get sub_heading => TextStyle(
        color: Color(Colours.color_primary_dark),
        fontFamily: Fonts.quicksand_bold,
        fontSize: 17.0,
        letterSpacing: 1.2,
      );

  static TextStyle get company => TextStyle(
        fontFamily: Fonts.quicksand_medium,
        color: Color(Colours.color_primary_dark),
        height: 1.5,
        fontSize: 15.0,
        letterSpacing: 1.0,
      );

  static TextStyle get body => TextStyle(
        fontFamily: Fonts.quicksand_medium,
        color: Color(Colours.color_primary_dark),
        height: 1.5,
        fontSize: 12.0,
        letterSpacing: 1.0,
      );

  static TextStyle get body1 => TextStyle(
        fontFamily: Fonts.quicksand_medium,
        color: Color(Colours.color_primary_dark),
        height: 1.5,
        fontSize: 10.0,
        letterSpacing: 1.0,
      );

  static TextStyle get chip => TextStyle(
        fontFamily: Fonts.quicksand_bold,
        color: Color(Colours.color_primary_dark),
        height: 1.5,
        fontSize: 12.0,
        letterSpacing: 1.0,
      );
}
