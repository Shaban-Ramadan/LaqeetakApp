import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/map_page.dart';
import 'feature/view/auth/new_password.dart';
import 'feature/view/auth/sign_in.dart';
import 'feature/view/auth/sign_up.dart';
import 'feature/view/auth/valedate_code_view.dart';
import 'feature/view/home/home_view.dart';
import 'feature/view/loser/lost_details_view.dart';
import 'feature/view/more/more_view.dart';
import 'feature/view/onboarding/onboarding1.dart';
import 'feature/view/onboarding/onboarding2.dart';
import 'feature/view/onboarding/onboarding3.dart';
import 'feature/view/onboarding/splash.dart';
import 'feature/view/posters/my_poster.dart';
import 'feature/view/search/search_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Vazirmatn',
          ),
          title: 'Lageetak',
          home: child,
        );
      },
      child: SplashView(),
    );
  }
}
