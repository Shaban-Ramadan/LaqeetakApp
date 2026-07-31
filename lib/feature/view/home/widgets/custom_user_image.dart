import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/services/local/shared_helper(1).dart';
import 'package:laqeetak/coure/services/local/shared_keys(1).dart';

import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/sytles.dart';

class CustomUserImage extends StatelessWidget {
  const CustomUserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.travel_explore,
          color: AppColors.background,
          size: 30.r, // متناسب مع الشاشة
        ),
        SizedBox(width: 5.w), // مسافة متناسبة
        Text(
          SharedHelper.get(key: SharedKeys.userLocationName) == null
              ? 'شارع علي التمام'
              : SharedHelper.get(key: SharedKeys.userLocationName),
          style: AppTextStyles.subHeading.copyWith(
            color: AppColors.background,
            fontSize: 12.sp, // متناسب مع الشاشة
          ),
        ),
        SizedBox(width: 5.w), // مسافة متناسبة
        Icon(
          Icons.location_on_outlined,
          color: AppColors.background,
          size: 30.r, // متناسب مع الشاشة
        ),
      ],
    );
  }
}
