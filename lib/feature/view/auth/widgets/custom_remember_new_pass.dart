
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';

class CustomRememberAndNewPass extends StatelessWidget {
  const CustomRememberAndNewPass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        var userCubit = UserCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                userCubit.resetPassword();
              },
              child: Text(
                "هل نسيت كلمة المرور؟",
                style: AppTextStyles.body.copyWith(
                  fontSize: 14.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "تذكرني",
                  style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                ),
                SizedBox(width: 6.w),
                IconButton(
                  onPressed: userCubit.swapRememberMe,
                  icon: Icon(
                    userCubit.rememberMe
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined,
                    color: userCubit.rememberMe ? Colors.green : Colors.grey,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
