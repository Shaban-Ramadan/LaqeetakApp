import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/feature/view/auth/sign_up.dart';
import 'package:laqeetak/feature/view/home/home_view.dart';
import 'package:laqeetak/feature/view/onboarding/onboarding1.dart';
import '../../../coure/utils/app_anigation(1).dart';
import '../../../coure/utils/app_images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double value = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();


    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        value += 0.050;
        if (value >= 1.0) {
          value = 1.0;
          _timer.cancel();
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            AppNavigation.pushAndRemove(context, HomePageView());
          } else {
            AppNavigation.pushAndRemove(context, Onboarding1View());
          }

        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 300.h),
              Image(
                image: AssetImage(AppImages.logo),
                width: 200.w,
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                        image: AssetImage(AppImages.logoTo),
                        width: 150.w,
                      ),
                    ],
                  ),
                  PositionedDirectional(
                    bottom: 50.h,
                    child: SizedBox(
                      width: 120.w,
                      child: LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.white,
                        color: AppColors.primary,
                        minHeight: 6.h,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
