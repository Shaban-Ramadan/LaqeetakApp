import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';

class CustomTextFormField extends StatelessWidget {
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final int maxLength;
  final String? hintText;
  final String? title;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final void Function()? onTap;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.autofocus = false,
    this.maxLength = 50,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.title,
    this.maxLines,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title ?? 'أدخل بريدك الإلكتروني',
          style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Stack(
          children: [
            TextFormField(
              readOnly: readOnly,
              onTap: onTap,
              textDirection: TextDirection.rtl,
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.emailAddress,
              obscureText: obscureText,
              autofocus: autofocus,
              maxLength: maxLength,
              maxLines: maxLines ?? 1,
              decoration: InputDecoration(
                isDense: true,
                counterText: '',
                hintText: hintText ?? 'أدخل بريدك الإلكتروني',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.sp,
                ),
                hintTextDirection: TextDirection.rtl,
                suffixIcon: SizedBox.shrink(),
                prefixIcon: prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.grey.shade500,
                    width: 1.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.5.w,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1.5.w,
                  ),
                ),
              ),
              validator: validator,
            ),
            Positioned(
              top: 20.h,
              right: 5.w,
              child: suffixIcon ?? SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}

