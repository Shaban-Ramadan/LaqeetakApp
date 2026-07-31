import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/services/local/shared_helper(1).dart';
import 'package:laqeetak/coure/services/local/shared_keys(1).dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';

import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/app_images.dart';
import '../../../../coure/utils/sytles.dart';
import '../../../../coure/widgets/arrow_back_Icon(1).dart';
import 'custom_user_image.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, state) {
        var userCubit = UserCubit.get(context);
        return Positioned(
          top: 0.h,
          left: 0.w,
          right: 0.w,
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0.w,
            toolbarHeight: 150.h,
            leadingWidth: 70.w,
            leading: Center(
              child: CustomIconButton(
                icon: Icon(
                  Icons.notifications_none_sharp,
                  color: AppColors.captionColor,
                  size: 24,
                ),
                onPressed: () {},
                shape: BoxShape.circle,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  SharedHelper.get(key: SharedKeys.userName) == null
                      ? ' laqeetak '
                      : SharedHelper.get(key: SharedKeys.userName),
                  style: AppTextStyles.subHeading.copyWith(
                    color: AppColors.background,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                CustomUserImage(),
              ],
            ),
            actions: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: userCubit.userImage == null
                    ? AssetImage(AppImages.userImage)
                    : FileImage(userCubit.userImage!) as ImageProvider,
              ),
              SizedBox(width: 10.w),
            ],
          ),
        );
      },
    );
  }
}
