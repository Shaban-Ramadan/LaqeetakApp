import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/feature/view/auth/sign_in.dart';
import 'package:laqeetak/feature/view/auth/valedate_code_view.dart';
import 'package:laqeetak/feature/view/auth/widgets/cusotm_policy_text.dart';
import 'package:laqeetak/feature/view/auth/widgets/custom_app_bar_sign_up.dart';
import 'package:laqeetak/feature/view/home/home_view.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';
import '../../../coure/utils/app_colors.dart';
import '../../../coure/widgets/button_custom(1).dart';
import 'widgets/custom_signup_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
          builder: (BuildContext context, state) {
            var userCubit = UserCubit.get(context);
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      CustomAppBarSignUp(),
                      SizedBox(height: 10.h),
                      CustomFormField(),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            AppNavigation.push(context, SignInView());
                          },
                          child: Text(
                            "هل لديك حساب بالفعل؟",
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      CustomPolicyText(userCubit: userCubit),
                      SizedBox(height: 10.h),
                      CustomButton(
                        onPressed: () {
                          userCubit.signUp();
                        },
                        color: AppColors.primary,
                        width: double.infinity,
                        height: 56.h,
                        text: state is UserLoadingSignUpState
                            ? SizedBox(
                          height: 15.h,
                          width: 15.w,
                          child: CircularProgressIndicator(
                            color: AppColors.background,
                          ),
                        )
                            : Text(
                          'إنشاء حساب',
                          style: AppTextStyles.subHeading2.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(17.r),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is UserAuthSignUpError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      'تاكد من صحة ملئ البيانات وعدم استخدامها سابقا',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  backgroundColor: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              );
            } else if (state is UserSuccessSignUpState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      'تم انشاء حساب بنجاح',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              );
              AppNavigation.pushAndRemove(context, SignInView());
            }
          },
        ),
      ),
    );
  }
}
