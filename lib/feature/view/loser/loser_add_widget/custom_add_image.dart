import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_states.dart';
import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/sytles.dart';

class CustomAddImage extends StatelessWidget {
  final int index;

  const CustomAddImage({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var loserCubit = LoserCubit.get(context);
    final imageFile = loserCubit.loserImages[index];

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () async {
        await loserCubit.loserPicImage(index);
      },
      child: imageFile != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
          height: 120.h,
          width: 115.w,
        ),
      )
          : Container(
        height: 120.h,
        width: 115.w,
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.captionColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: AppColors.captionColor,
              size: 24.sp,
            ),
            SizedBox(height: 5.h),
            Text(
              'إضافة صورة',
              style: AppTextStyles.body.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}