import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../coure/utils/sytles.dart';

class CustomDetailsLoser extends StatelessWidget {
  final String title;         // عنوان العنصر
  final String date;          // تاريخ العثور
  final String category;      // القسم
  final String location;      // الموقع الكامل
  final String description;
  final String commentsTitle; // عنوان قسم التعليقات

  const CustomDetailsLoser({
    super.key,
    required this.title,
    required this.date,
    required this.category,
    required this.location,
    required this.description,
    this.commentsTitle = 'تعليقات ',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text(title, style: AppTextStyles.subHeading.copyWith(fontSize: 16.sp)),
            Text('نشر منذ اسبوع', style: AppTextStyles.content.copyWith(fontSize: 14.sp)),
          ],
        ),
        SizedBox(height: 6.h),
        Text('التاريخ العثور', style: AppTextStyles.content.copyWith(fontSize: 14.sp)),
        Text(date, style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp)),
        SizedBox(height: 6.h),
        Text('القسم', style: AppTextStyles.content.copyWith(fontSize: 14.sp)),
        Text(category, style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp)),
        SizedBox(height: 6.h),
        Text('الموقع العثور', style: AppTextStyles.content.copyWith(fontSize: 14.sp)),
        Text(
          location,
          textDirection: TextDirection.rtl,
          style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 6.h),
        Text('وصف عن العثور عليه', style: AppTextStyles.content.copyWith(fontSize: 14.sp)),
        Text(
          description,
          textDirection: TextDirection.rtl,
          style: AppTextStyles.subHeading.copyWith(fontSize: 12.sp),
        ),
        SizedBox(height: 10.h),
        Text(commentsTitle, style: AppTextStyles.content.copyWith(fontSize: 14.sp)),
      ],
    );
  }
}


