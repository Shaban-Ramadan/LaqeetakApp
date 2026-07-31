import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/app_images.dart';
import '../../../../coure/utils/sytles.dart';

class CustomUserComment extends StatelessWidget {
  final String? userName;
  final String? userImage;

  const CustomUserComment({
    this.userName,
    this.userImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'تعليق',
          style: AppTextStyles.content.copyWith(fontSize: 14.sp),
        ),
        SizedBox(width: 7.w),
        Stack(
          textDirection: TextDirection.rtl,
          children: [
            Icon(Icons.comment, color: AppColors.captionColor, size: 20.sp),
            Positioned(
              right: 0,
              top: 0,
              child: CircleAvatar(
                radius: 3.r,
                backgroundColor: AppColors.red,
              ),
            )
          ],
        ),
        Spacer(),
        Text(
          userName ?? '',
          style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp),
        ),
        SizedBox(width: 7.w),
        CircleAvatar(
          radius: 20.r,
          backgroundImage: userImage != null
              ? NetworkImage(userImage!)
              : AssetImage(AppImages.userImage) as ImageProvider,
        ),
      ],
    );
  }
}