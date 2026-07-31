import 'package:flutter/material.dart';

import 'app_colors.dart';
class AppTextStyles {
  static const TextStyle onboardingTitle = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.fontColor,
  );
  static const TextStyle subHeading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    color: AppColors.subtitleColor,
  );
  static const TextStyle hintText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,

  );
  static const TextStyle content = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.captionColor,
  );
  static const TextStyle smallContent = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.captionColor,
  );
}
