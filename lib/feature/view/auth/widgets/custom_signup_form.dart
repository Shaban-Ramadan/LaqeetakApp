import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import '../widgets/customTextFormField.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({super.key});

  @override
  Widget build(BuildContext context) {
    var userCubit = UserCubit.get(context);
    return Form(
      autovalidateMode: userCubit.autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            title: 'الاسم',
            controller: userCubit.nameController,
            validator: (value) => userCubit.validateName(value),
            suffixIcon: Icon(
              Icons.person_outline,
              size: 20.sp,
              color: Colors.grey,
            ),
            hintText: 'ادخل الاسم بالكامل',
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            title: 'البريد الاكتروني',
            controller: userCubit.signUpEmailController,
            validator: (value) => userCubit.validateEmail(value),
            suffixIcon: Icon(
              Icons.email_outlined,
              size: 20.sp,
              color: Colors.grey,
            ),
            hintText: 'ادخل البريد الاكتروني',
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            title: 'رقم الهاتف',
            controller: userCubit.phoneController,
            validator: (value) => userCubit.validateNumber(value),
            suffixIcon: Icon(
              Icons.phone,
              size: 20.sp,
              color: Colors.grey,
            ),
            hintText: 'ادخل رقم الهاتف',
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            title: 'المدينة',
            controller: userCubit.locationController,
            validator: (value) => userCubit.validatePassword(value),
            suffixIcon: Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: Colors.grey,
            ),
            hintText: 'ادخل موقعك',
          ),
          CustomTextFormField(
            title: 'الرقم السري',
            controller: userCubit.signUpPasswordController,
            validator: (value) => userCubit.validatePassword(value),
            suffixIcon: Icon(
              Icons.lock_outline,
              size: 20.sp,
              color: Colors.grey,
            ),
            prefixIcon: IconButton(
              onPressed: userCubit.togglePasswordVisibilitSignUp,
              icon: Icon(
                userCubit.obscureSignUp
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: userCubit.obscureSignUp ? Colors.red : Colors.green,
                size: 20.sp,
              ),
            ),
            hintText: 'ادخل كلمة المرور',
            obscureText: userCubit.obscureSignUp,
          ),
        ],
      ),
    );
  }
}
