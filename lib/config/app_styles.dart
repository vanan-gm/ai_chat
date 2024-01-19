import 'package:ai_chat/config/app_colors.dart';
import 'package:ai_chat/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppStyles{
  AppStyles._();

  static TextStyle defaultStyle({
    double? fontSize,
    Color? textColor,
    FontWeight? fontWeight,
    TextDecoration? decoration}){
    return TextStyle(
      fontFamily: 'Nunito',
      fontSize: fontSize ?? AppConstants.textSizeDefault,
      color: textColor ?? AppColors.black,
      fontWeight: fontWeight ?? FontWeight.w500,
      decoration: decoration ?? TextDecoration.none,
      letterSpacing: AppConstants.letterSpacingDefault,
    );
  }
}