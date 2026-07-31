import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/feature/view/auth/widgets/customTextFormField.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userCubit = UserCubit.get(context);
    return Form(
      autovalidateMode: userCubit.autovalidateMode,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            title: 'البريد الإلكتروني',
            controller: userCubit.loginEmailController,
            hintText: 'ادخل البريد الإلكتروني',
            suffixIcon: Icon(
              Icons.email_outlined,
              size: 20.sp,
            ),
            validator: (value) {
              return userCubit.validateEmail(value);
            },
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            title: 'الرقم السري',
            controller: userCubit.loginPasswordController,
            hintText: 'ادخل الرقم السري',
            obscureText: userCubit.obscureLogin,
            validator: (value) {
              return userCubit.validatePassword(value);
            },
            prefixIcon: IconButton(
              onPressed: userCubit.togglePasswordVisibilityLogin,
              icon: Icon(
                userCubit.obscureLogin
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: userCubit.obscureLogin ? Colors.red : Colors.green,
                size: 20.sp,
              ),
            ),
            suffixIcon: Icon(
              Icons.lock_outline,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
