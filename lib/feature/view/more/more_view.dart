import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/feature/view/auth/sign_in.dart';
import 'package:laqeetak/feature/view/more/widgets/custom_profile_element.dart';
import 'package:laqeetak/feature/view/more/widgets/custom_user_profile_image.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';

class MoreView extends StatelessWidget {
  MoreView({super.key});

  final List<String> titles = [
    'من نحن',
    'الابلاغ عن عطل',
    'مشاركة',
    'الاسئلة عنا',
    'السياسة الخصوصية',
    'الشروط و الاحكام ',
    'تسجيل الخروج',
  ];

  final List<Widget> suffixIcons = [
    Icon(
      Icons.help_outline,
      color: AppColors.captionColor,
    ),
    Icon(
      Icons.phone_callback,
      color: AppColors.captionColor,
    ),
    Icon(
      Icons.share,
      color: AppColors.captionColor,
    ),
    Icon(
      Icons.live_help_outlined,
      color: AppColors.captionColor,
    ),
    Icon(
      Icons.lock_outline,
      color: AppColors.captionColor,
    ),
    Icon(
      Icons.safety_check_outlined,
      color: AppColors.captionColor,
    ),
    Icon(
      Icons.exit_to_app,
      color: AppColors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<VoidCallback> actions = [
      () {
        // من نحن
        print('من نحن');
      },
      () {
        // الابلاغ عن عطل
        print('الابلاغ عن عطل');
      },
      () {
        // مشاركة
        print('مشاركة');
      },
      () {
        // الاسئلة عنا
        print('الاسئلة عنا');
      },
      () {
        // السياسة الخصوصية
        print('السياسة الخصوصية');
      },
      () {
        // الشروط و الاحكام
        print('الشروط و الاحكام');
      },
      () {
        // تسجيل الخروج
        UserCubit.get(context).signOut(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.red,
            content: Center(child: Text("تم تسجيل الخروج"))));
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (BuildContext context, state) {
          var userCubit = UserCubit.get(context);
          return Stack(
            children: [
              /// الخلفية العلوية
              Container(
                height: 178.h,
                color: AppColors.primary,
              ),

              /// المحتوى الرئيسي
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 210.h, start: 15.w, end: 15.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    /// user actions
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.captionColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'عن تفاعلاتي',
                            style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(height: 20.h),
                          CustomProfileElement(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    /// about Laqeetak
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.captionColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'عن Laqeetak',
                              style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                            ),
                            SizedBox(height: 10.h),
                            Expanded(
                              child: ListView.separated(
                                itemCount: titles.length,
                                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                                itemBuilder: (context, index) {
                                  return CustomProfileElement(
                                    onTap: actions[index],
                                    prefixIcon: index == titles.length - 1
                                        ? SizedBox()
                                        : Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.captionColor,
                                      size: 18.sp,
                                    ),
                                    title: titles[index],
                                    titleColor: index == titles.length - 1
                                        ? AppColors.red
                                        : AppColors.fontColor,
                                    suffixIcon: suffixIcons[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// user profile image
              Positioned(
                top: 135.h,
                left: (MediaQuery.of(context).size.width / 2) - 40.w,
                child: CustomUserProfile(),
              ),
            ],
          );
        },
        listener: (BuildContext context, state) {},
      ),
    );
  }
}
