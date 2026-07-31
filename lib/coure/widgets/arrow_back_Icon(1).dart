import 'package:flutter/material.dart';


import '../utils/app_colors.dart';


class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.widthSize = 40,
    this.heightSize = 40,
    this.radius = 15,
    this.margin = const EdgeInsetsDirectional.only(end: 12),
    this.borderWidth = 1,
    required this.shape,
  this.borderRadius,
  });

  final Widget icon;
  final void Function()? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double widthSize;
  final double heightSize;
  final double radius;
  final EdgeInsetsGeometry margin;
  final double borderWidth;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: widthSize,
      height: heightSize,
      decoration: BoxDecoration(
        borderRadius:borderRadius,
        color: AppColors.background,
        shape: shape,
        border: Border.all(color: AppColors.captionColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.captionColor.withOpacity(0.6), // لون الظل
            blurRadius: 10, // نعومة الظل
            spreadRadius: 0.5, // انتشار الظل
            offset: Offset(0, 3), // اتجاه الظل
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon:icon ,
        color: AppColors.captionColor,
      ),
    );
  }
}