import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_images.dart';
import 'package:laqeetak/feature/view/auth/widgets/custom_app_bar_login.dart';
import 'package:laqeetak/feature/view/auth/widgets/custom_have_account.dart';
import 'package:laqeetak/feature/view/auth/widgets/custom_login_form.dart';
import 'package:laqeetak/feature/view/auth/widgets/custom_remember_new_pass.dart';
import 'package:laqeetak/feature/view/home/home_view.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';
import '../../../coure/utils/app_colors.dart';
import '../../../coure/utils/sytles.dart';
import '../../../coure/widgets/button_custom(1).dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (BuildContext context, state) {
          var userCubit = UserCubit.get(context);
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 20.h),
                  CustomAppBarLogin(),
                  SizedBox(height: 30.h),
                  Text(
                    "أهلاً بك",
                    textAlign: TextAlign.right,
                    style: AppTextStyles.onboardingTitle.copyWith(fontSize: 22.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "اذا فقدت شيء يمكنك البحث داخل التطبيق.",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(height: 15.h),
                  CustomLoginForm(),
                  SizedBox(height: 10.h),
                  CustomRememberAndNewPass(),
                  CustomButton(
                    onPressed: () {
                      userCubit.signIn();
                    },
                    color: AppColors.primary,
                    text: state is UserLoadingLoginState
                        ? SizedBox(
                      height: 15.h,
                      width: 15.w,
                      child: CircularProgressIndicator(
                        color: AppColors.background,
                      ),
                    )
                        : Text(
                      'دخول',
                      style: AppTextStyles.subHeading2.copyWith(fontSize: 16.sp),
                    ),
                  ),
                  CustomHaveAccount(),
                  SizedBox(height: 10.h),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: state is UserLoadingLoginState
                        ? CircularProgressIndicator()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          'Continue with Google',
                          style: AppTextStyles.subHeading.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Image(
                          image: AssetImage(AppImages.google),
                          width: 40.w,
                          height: 40.h,
                        ),
                      ],
                    ),
                    onPressed: state is UserLoadingLoginState
                        ? null
                        : () {
                      userCubit.signInWithGoogle();
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is UserAuthLogInError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "حدث خطأ"),
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          }

          if (state is UserSuccessLoginState || state is UserSignInWithGoogleState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text('مرحباً', style: TextStyle(fontSize: 16.sp))),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );

            if (!context.mounted) return;

            AppNavigation.pushAndRemove(context, HomePageView());
          }
        },
      ),
    );
  }
}


