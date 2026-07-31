import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/coure/widgets/arrow_back_Icon(1).dart';
import 'package:laqeetak/feature/view/auth/sign_up.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_states.dart';

class ValidateCodeView extends StatelessWidget {
  final String verificationId;

  const ValidateCodeView({super.key, required this.verificationId});

  String getEnteredCode(List<TextEditingController> controllers) {
    return controllers.map((c) => c.text.trim()).join();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        AppNavigation.pushAndRemove(context, SignUpView());
                      },
                      shape: BoxShape.circle,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('كود التحقق', style: AppTextStyles.onboardingTitle),
                Text('ادخل رمز التحقق المرسل على الموبايل',
                    style: AppTextStyles.body),
                const SizedBox(height: 30),

                /// OTP Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 78,
                      height: 81,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        cursorColor: AppColors.primary,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),

                /// زر التأكيد
                Center(
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text('تأكيد الكود'),
                  ),
                ),

                const SizedBox(height: 20),

                /// إعادة الإرسال
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('هل تلقيت الرمز؟',
                        style: AppTextStyles.content.copyWith(fontSize: 12)),
                    TextButton(
                      onPressed: () {
                      },
                      child: Text('إعادة الإرسال',
                          style: AppTextStyles.body.copyWith(
                              color: AppColors.primary, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
