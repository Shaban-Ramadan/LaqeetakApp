import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/sytles.dart';
import '../../../model/loser_model.dart';
import '../../loser/lost_details_view.dart';

class CustomLoserWidget extends StatelessWidget {
  final LoserItemModel item;

  const CustomLoserWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        AppNavigation.push(
          context,
          LostDetailsView(item: item),
        );
      },
      child: Container(
        width: 130.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(color: AppColors.captionColor, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min, // ارتفاع ديناميكي حسب المحتوى
          children: [
            // الصورة
        ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      child: (item.images != null &&
          item.images!.isNotEmpty &&
          item.images!.first.trim().isNotEmpty)
          ? Image.network(
        item.images!.first,
        width: double.infinity,
        height: 70.h,
        fit: BoxFit.cover,
        // أثناء تحميل الصورة
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            // الصورة انتهت من التحميل
            return child;
          }
          // أثناء التحميل
          return Container(
            width: double.infinity,
            height: 70.h,
            color: AppColors.background,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
                color: AppColors.primary, // اللون الرئيسي للثيم
                strokeWidth: 2.0,
              ),
            ),
          );
        },
        // لو فشل التحميل لأي سبب
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.background,
            height: 70.h,
            width: double.infinity,
            child: Icon(
              Icons.image_not_supported,
              size: 30.r,
              color: AppColors.captionColor,
            ),
          );
        },
      )
          : Container(
        color: AppColors.background,
        height: 70.h,
        width: double.infinity,
        child: Icon(
          Icons.image_not_supported,
          size: 30.r,
          color: AppColors.captionColor,
        ),
      ),
    ),

            // العنوان
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
              child: Text(
                item.title,
                style: AppTextStyles.subHeading.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // منع النص الطويل من كسر التصميم
              ),
            ),

            // الموقع
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      item.locationName,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.captionColor,
                    size: 16.sp,
                  ),
                ],
              ),
            ),

            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }
}
