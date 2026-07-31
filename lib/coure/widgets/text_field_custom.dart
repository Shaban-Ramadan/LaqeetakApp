import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/sytles.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      required this.obscureText,
      this.controller,
      this.validator,
      this.height = 55,
      this.width = 365});

  final bool obscureText;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.subtitleColor,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle: const TextStyle(height: 1.2),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: AppColors.captionColor,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: AppColors.red,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: AppColors.red,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.red)),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.5),
          ),
          hintText: hintText,
          hintStyle: AppTextStyles.hintText,
          hintTextDirection: TextDirection.rtl,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        textDirection: TextDirection.rtl,
        obscureText: obscureText,
        style: AppTextStyles.hintText.copyWith(
          color: AppColors.fontColor,
        ),
        validator: validator,
      ),
    );
  }
}
