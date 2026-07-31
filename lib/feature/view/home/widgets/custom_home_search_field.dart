import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';

class CustomHomeSearchField extends StatelessWidget {
  final void Function(String)? onChanged;
  const CustomHomeSearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    var loserCubit = LoserCubit.get(context);
    return Positioned(
      top: 150.h,
      left: 16.w,
      right: 16.w,
      child: SizedBox(
        height: 50.h,
        child: Material(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.background,
          child: TextFormField(
            onChanged: onChanged,
            cursorColor: AppColors.primary,
            textDirection: TextDirection.rtl,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            decoration: InputDecoration(
              counterText: '',
              hintText: 'ابحث بالاسم - الفئة - المكان',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 15.sp,
              ),
              hintTextDirection: TextDirection.rtl,
              suffixIcon: Icon(Icons.search, size: 24.sp),
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
                  color: Colors.grey.shade500,
                  width: 1.5.w,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
