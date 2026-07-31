import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/sytles.dart';

class CustomProfileElement extends StatelessWidget {
  final Widget? suffixIcon;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final String? title;
  final Color? titleColor;

  const CustomProfileElement({
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.titleColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h), // padding responsive
        child: Row(
          children: [
            prefixIcon ??
                Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.captionColor,
                  size: 20.sp, // حجم responsive
                ),
            Spacer(),
            Text(
              title ?? 'تعليقاتي',
              style: AppTextStyles.subHeading.copyWith(
                color: titleColor ?? AppColors.fontColor,
                fontSize: 16.sp, // حجم نص responsive
              ),
            ),
            SizedBox(width: 10.w),
            suffixIcon ??
                Icon(
                  Icons.comment,
                  color: AppColors.captionColor,
                  size: 20.sp, // حجم responsive
                ),
          ],
        ),
      ),
    );
  }
}