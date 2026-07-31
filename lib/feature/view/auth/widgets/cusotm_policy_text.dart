import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';

class CustomPolicyText extends StatelessWidget {
  const CustomPolicyText({
    super.key,
    required this.userCubit,
  });

  final UserCubit userCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'بالتسجيل فانك توافق على ',
                style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'و ',
                    style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp),
                  ),
                  Flexible(
                    child: Text(
                      'شروط الاستخدام الخاصة بنا ',
                      style: AppTextStyles.subHeading.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'سياسة الخصوصية ',
                style: AppTextStyles.subHeading.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: userCubit.swapPolicy,
          icon: userCubit.isSelected
              ? Icon(
            Icons.check_box,
            color: Colors.green,
            size: 24.sp,
          )
              : Icon(
            Icons.check_box_outline_blank_outlined,
            color: Colors.grey,
            size: 24.sp,
          ),
        ),
      ],
    );
  }
}