import 'package:flutter/material.dart';

class AppConstants{
  AppConstants._();

  static MediaQueryData get mediaQuery => MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
  static double get width => mediaQuery.size.width;
  static double get height => mediaQuery.size.height;

  // TextSizes
  static const double textSizeSmallest = 12;
  static const double textSizeSmall = 14;
  static const double textSizeDefault = 15;
  static const double textSizeBig = 18;
  static const double textSizeLarge = 20;
  static const double textSizeHuge = 24;

  // Icons
  static const double iconSizeSmallest = 18;
  static const double iconSizeSmall = 20;
  static const double iconSizeDefault = 24;
  static const double iconSizeBig = 28;
  static const double iconSizeLarge = 32;
  static const double iconSizeHuge = 40;

  // Paddings
  static double paddingZero = AppConstants.width * .0;
  static double paddingTiny = AppConstants.width * .005;
  static double paddingSmallest = AppConstants.width * .01;
  static double paddingSmall = AppConstants.width * .02;
  static double paddingDefault = AppConstants.width * .025;
  static double paddingBig = AppConstants.width * .03;
  static double paddingLarge = AppConstants.width * .04;
  static double paddingHuge = AppConstants.width * .05;
  static double paddingSuperHuge = AppConstants.width * .1;

  // Radius
  static const double radiusImage = 5.0;
  static const double radiusContainer = 8.0;
  static const double radiusCard = 10.0;
  static const double radiusDialog = 15.0;
  static const double radiusRound = 20.0;
  static const double radiusCircle = 50.0;

  // Elevations
  static const double noElevation = 0.0;
  static const double defaultElevation = 2.0;

  // Durations
  static const Duration durationAnimation = Duration(milliseconds: 200);
  static const Duration durationSplash = Duration(seconds: 2);
  static const Duration durationNavigation = Duration(milliseconds: 500);

  // Others
  static const double buttonHeight = 50.0;
  static const double letterSpacingDefault = .004;

}