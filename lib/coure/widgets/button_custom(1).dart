import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    required this.onPressed,
    this.height = 48,
    this.width = 365,
    this.color = AppColors.primary,
    this.borderRadius,
  });

  final Widget? text;
  final void Function()? onPressed;
  final double height;
  final double width;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      height: height,
      minWidth: width,
      shape:  RoundedRectangleBorder(
          borderRadius:borderRadius ?? BorderRadius.all(Radius.circular(12)),
      ),
      child: text ,
    );
  }
}
