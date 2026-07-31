import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/feature/view/auth/sign_up.dart';

class CustomHaveAccount extends StatelessWidget {
  const CustomHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
        Text(
          'ليس لديك حساب؟',
          style: AppTextStyles.caption.copyWith(fontSize: 14.sp),
        ),
        TextButton(
          onPressed: () {
            AppNavigation.push(context, SignUpView());
          },
          child: Text(
            "تسجيل جديد",
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}