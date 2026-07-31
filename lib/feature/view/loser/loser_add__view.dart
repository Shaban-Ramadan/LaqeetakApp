import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/coure/widgets/button_custom(1).dart';
import 'package:laqeetak/feature/view/home/home_view.dart';
import 'package:laqeetak/feature/view/loser/loser_add_widget/custom_list_view_add_image.dart';
import 'package:laqeetak/feature/view/loser/loser_add_widget/custom_list_view_text_field.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_states.dart';
import '../../../coure/widgets/arrow_back_Icon(1).dart';

class AddLostView extends StatelessWidget {
  AddLostView({super.key});

  @override
  Widget build(BuildContext context) {
    var loserCubit = LoserCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'تسجيل بلاغ',
              style: AppTextStyles.onboardingTitle.copyWith(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(width: 15.w),
          ],
        ),
        actions: [
          CustomIconButton(
            backgroundColor: AppColors.background,
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.captionColor,
              size: 20.sp,
            ),
            shape: BoxShape.circle,
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: SingleChildScrollView(
            child: BlocConsumer<LoserCubit, LoserState>(
              builder: (BuildContext context, state) {
                return Column(
                  children: [
                    SizedBox(height: 10.h),

                    /// caption
                    Text(
                      'يرجى ملء بيانات بدقة لضمان عرض كافة التفاصيل بشكل صحيح.',
                      style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 10.h),
                    /// list view add image
                    const CustomListViewAddImage(),
                    SizedBox(height: 10.h),
                    /// list view text field
                    CustomListViewTextField(),
                    SizedBox(height: 12.h),
                    /// نشر
                    CustomButton(
                      onPressed: () async {
                        if (loserCubit.loserNameController.text.trim().isEmpty ||
                            loserCubit.selectedCategory == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("الرجاء تعبئة الاسم والتصنيف"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        await loserCubit.uploadLoserImages();
                        // رفع البيانات بعد رفع الصور
                        await loserCubit.storeLoserData();
                      },
                      color: AppColors.primary,
                      text: state is LoserUploadLoadingState
                          ? SizedBox(
                        height: 15.h,
                        width: 15.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 0.7,
                          backgroundColor: AppColors.background,
                        ),
                      )
                          : Text(
                        'نشر',
                        style: AppTextStyles.subHeading.copyWith(
                          color: AppColors.background,
                          fontSize: 14.sp,
                        ),
                      ),
                      height: 50.h,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    SizedBox(height: 12.h),
                  ],
                );
              },
              listener: (BuildContext context, LoserState state) {
                if (state is LoserUploadSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(
                        child: Text('منشورك جاهز للعرض'),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                  loserCubit.loserImages = [null, null, null];
                  AppNavigation.push(context, const HomePageView());
                } else if (state is LoserUploadErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('حدث خطأ: ${state.error}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
