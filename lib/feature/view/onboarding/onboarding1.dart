import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_images.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/feature/view/onboarding/onboarding2.dart';

class Onboarding1View extends StatelessWidget {
  const Onboarding1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Center(
                child: Image.asset(
                  AppImages.onboarding1,
                  height: 300.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Text(
                    "ارفع الشيء الذي عثرت عليه",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.onboardingTitle.copyWith(
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    textDirection: TextDirection.rtl,
                    "عندما تعثر على شيء مفقود يمكنك التقاط صورة ورفعها في غضون ثواني.. وساعد اصاحبها للوصل اليها بسرعة.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildDot(isActive: false),
                      SizedBox(width: 6.w),
                      buildDot(isActive: false),
                      SizedBox(width: 6.w),
                      buildDot(isActive: true),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    AppNavigation.push(context, Onboarding2View());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1E88E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "التالي",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
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
