import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Config {
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isMacOS => Platform.isMacOS;

  static bool isPotrait(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.portrait;
  }

  static double height(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height - mediaQuery.viewPadding.vertical;
  }

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static TextStyle h1(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 3),
        fontWeight: FontWeight.w700,
        height: 1.6,
      );

  static TextStyle h2(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 2.5),
        fontWeight: FontWeight.w700,
        height: 1.6,
      );

  static TextStyle h3b(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 2.1),
        fontWeight: FontWeight.w700,
        height: 1.6,
      );

  static TextStyle h3(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 2.1),
        height: 1.6,
      );

  static TextStyle b1(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 1.7),
        height: 1.6,
      );

  static TextStyle b1b(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 1.7),
        fontWeight: FontWeight.w700,
        height: 1.6,
      );

  static TextStyle b2(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 1.5),
        height: 1.6,
      );

  static TextStyle b2b(BuildContext context) => GoogleFonts.sora(
        fontSize: textSize(context, 1.5),
        fontWeight: FontWeight.w700,
        height: 1.6,
      );

  static EdgeInsets contentPadding(BuildContext context,
      {double? h, double? v}) {
    if (v != null) {
      return EdgeInsets.symmetric(
          horizontal: xMargin(context, h ?? 0), vertical: yMargin(context, v));
    }
    return EdgeInsets.symmetric(
        horizontal: xMargin(context, h ?? 5),
        vertical: yMargin(context, v ?? 0));
  }

  static double yMargin(BuildContext context, double height) {
    double viewPortHeight = MediaQuery.of(context).size.longestSide;
    viewPortHeight = viewPortHeight > 950 ? 950 : viewPortHeight;
    return height * (viewPortHeight / 100);
  }

  static double xMargin(BuildContext context, double width) {
    double viewPortwidth = MediaQuery.of(context).size.shortestSide;
    viewPortwidth = viewPortwidth > 650 ? 650 : viewPortwidth;
    return width * (viewPortwidth / 100);
  }

  static double textSize(BuildContext context, double size) {
    double vph = MediaQuery.of(context).size.longestSide;
    double vpw = MediaQuery.of(context).size.shortestSide;

    final val = pow(vph, 2) + pow(vpw, 2);

    double hyp = sqrt(val);
    hyp = hyp > 1000 ? 1000 : hyp;

    return size * (hyp / 100);
  }
}
