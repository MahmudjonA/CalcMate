import 'package:calculator/core/color/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: AppColors.white,
    primary: AppColors.lightGrey,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: AppColors.black,
    primary: AppColors.grey,

  ),
);
