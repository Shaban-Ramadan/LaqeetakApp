import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_images.dart';
import 'package:laqeetak/feature/view/onboarding/onboarding3.dart';

class Onboarding2View extends StatelessWidget {
  const Onboarding2View({super.key});

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
                  AppImages.onboarding2,
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
                    "ابحث بسهولة على مفقوداتك",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "ابحث بالاسم أو المكان وانظر اذا قام احدهم برفعة سابقا",
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
                      buildDot(isActive: true),
                      SizedBox(width: 6.w),
                      buildDot(isActive: false),
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
                    AppNavigation.push(context, const Onboarding3View());
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
/// DOT INDICATOR WIDGET
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
