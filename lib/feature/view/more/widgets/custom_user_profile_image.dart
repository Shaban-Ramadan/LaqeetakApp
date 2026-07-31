import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/app_images.dart';

class CustomUserProfile extends StatelessWidget {
  const CustomUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userCubit = UserCubit.get(context);
    return Positioned(
      top: 135.h, // responsive top
      left: (MediaQuery.of(context).size.width / 2) - 40.w, // توسيط بالعرض
      child: SizedBox(
        height: 80.h,
        width: 80.w,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 40.r, // responsive radius
              backgroundImage: userCubit.userImage == null
                  ? AssetImage(AppImages.userImage)
                  : FileImage(userCubit.userImage!) as ImageProvider,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(30.r),
                onTap: () {
                  userCubit.userPicImage();
                },
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.background,
                    size: 15.sp, // responsive size
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}