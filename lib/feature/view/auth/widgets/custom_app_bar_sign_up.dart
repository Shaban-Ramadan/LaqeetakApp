import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/coure/widgets/arrow_back_Icon(1).dart';
import 'package:laqeetak/feature/view/auth/sign_in.dart';

class CustomAppBarSignUp extends StatelessWidget {
  const CustomAppBarSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        CustomIconButton(
          shape: BoxShape.circle,
          borderColor: AppColors.captionColor,
          backgroundColor: AppColors.background,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.captionColor,
            size: 20.sp,
          ),
          onPressed: () {
            AppNavigation.push(context, SignInView());
          },
        ),
        SizedBox(width: 10.w),
        Text(
          'إنشاء حساب',
          style: AppTextStyles.onboardingTitle.copyWith(fontSize: 22.sp),
        ),
      ],
    );
  }
}