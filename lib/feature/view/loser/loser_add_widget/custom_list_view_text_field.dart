import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/utils/sytles.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/map_page.dart';
import 'package:latlong2/latlong.dart';

import '../../auth/widgets/customTextFormField.dart';

class CustomListViewTextField extends StatelessWidget {
  const CustomListViewTextField({
    super.key,
  });

  final Color? iconColor = AppColors.captionColor;

  @override
  Widget build(BuildContext context) {
    var loserCubit = LoserCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextFormField(
          controller: loserCubit.loserNameController,
          title: 'اسم المعثور عليه',
          hintText: ' مفاتح -موبايل-محفظة- ساعة ',
          suffixIcon: Icon(
            Icons.square,
            color: iconColor,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'أدخل القسم ',
          style: AppTextStyles.subHeading.copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButtonFormField<String>(
            borderRadius: BorderRadius.circular(12.r),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            focusColor: AppColors.primary,
            dropdownColor: AppColors.background,
            value: loserCubit.selectedCategory,
            hint: const Text('اختر الفئة'),
            items: loserCubit.categories
                .map(
                  (e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: TextStyle(fontSize: 14.sp)),
              ),
            )
                .toList(),
            onChanged: loserCubit.changeCategory,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.book),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5.w,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 1.w),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        CustomTextFormField(
          controller: loserCubit.loserDateController,
          title: 'ادخل التاريخ',
          hintText: 'ادخل التاريخ ',
          suffixIcon: Icon(
            Icons.date_range,
            color: iconColor,
          ),
        ),
        CustomTextFormField(
          readOnly: true,
          controller: loserCubit.loserLocationSearchController,
          onTap: () async {
            final result = await Navigator.push<Map<String, dynamic>>(
              context,
              MaterialPageRoute(builder: (_) => const MapPage()),
            );

            if (result != null) {
              loserCubit.loserLocationSearchController.text =
                  result['name'] ?? "Lat: ${result['lat']}, Lng: ${result['lng']}";
              loserCubit.latitude = result['lat']!;
              loserCubit.longitude = result['lng']!;
              loserCubit.loserLocation = LatLng(result['lat']!, result['lng']!);
            }
          },
          title: 'الموقع العثور عليه',
          hintText: "ادخل الموقع",
          suffixIcon: Icon(
            Icons.location_on_outlined,
            color: iconColor,
          ),
        ),
        CustomTextFormField(
          keyboardType: TextInputType.multiline,
          controller: loserCubit.loserDiscretionController,
          maxLines: 5,
          maxLength: 200,
          title: 'اكتب وصف عن العثور عليه',
          hintText: " ادخل وصف ",
          suffixIcon: Icon(
            Icons.comment,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}
