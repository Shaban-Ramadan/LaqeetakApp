import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/coure/widgets/arrow_back_Icon(1).dart';
import 'package:laqeetak/feature/view/auth/sign_in.dart';
import 'package:laqeetak/feature/view/auth/widgets/customTextFormField.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';
import '../../../coure/utils/app_colors.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, state) {
          var userCubit = UserCubit.get(context);
          return SafeArea(
              child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  CustomIconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        AppNavigation.push(context, SignInView());
                      },
                      shape: BoxShape.circle),
                ]),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'كلمة المرور الجديدة',
                  style: AppTextStyles.onboardingTitle.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'الرجاء ادخال الرقم السري الجديد ',
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  title: 'الرقم السري',
                  hintText: 'ادخل الرقم السري',
                  suffixIcon: Icon(Icons.lock_outline),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  title: 'تاكيد الرقم السري',
                  hintText: 'ادخل الرقم السري',
                  suffixIcon: Icon(Icons.lock_outline),
                ),
              ],
            ),
          ));
        },
        listener: (context, state) {
          if (state is ResetPassLoadState) {
            CircularProgressIndicator();
          }

          if (state is ResetPassSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                    child: Text(
                      textDirection: TextDirection.rtl,
                        'تم إرسال رابط إعادة تعيين كلمة المرور على الإيميل')),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is ResetPassErorrState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.message.toString())),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
