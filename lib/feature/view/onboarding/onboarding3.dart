import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/app_images.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/coure/widgets/button_custom(1).dart';
import 'package:laqeetak/feature/view/auth/sign_in.dart';
import 'package:laqeetak/feature/view/auth/sign_up.dart';


class Onboarding3View extends StatelessWidget {
  const Onboarding3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Center(
                child: Image.asset(
                  AppImages.onboarding3,
                  height: 300.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Text(
                    "اطلب استرجاع في خطوة واحدة",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    textDirection: TextDirection.rtl,
                    "عند العثور على مفقودك يمكنك تقديم طلب استرجاع والتطبيق يوصلك لصاحب البلاغ.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildDot(isActive: true),
                      SizedBox(width: 6.w),
                      buildDot(isActive: false),
                      SizedBox(width: 6.w),
                      buildDot(isActive: false),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              onPressed: () {
                AppNavigation.pushAndRemove(context, SignUpView());
              },
              color: AppColors.primary,
              text: Text(
                'تسجيل الدخول',
                style: AppTextStyles.subHeading.copyWith(
                  color: AppColors.background,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8.h,
      width: isActive ? 20.w : 8.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(50.r),
      ),
    );
  }
}
Widget buildDot({required bool isActive}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 8,
    width: isActive ? 20 : 8,
    decoration: BoxDecoration(
      color: isActive ? Colors.blue : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(50),
    ),
  );
}