import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    this.text,
    required this.onPressed,
    this.height = 48,
    this.width = 365,
    this.color = AppColors.primary,
  });

  final Widget? text;
  final void Function()? onPressed;
  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      height: height,
      minWidth: width,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(12))),
      child: text,
    );
  }
}
