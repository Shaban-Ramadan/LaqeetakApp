import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/coure/utils/app_colors.dart';
import 'package:laqeetak/coure/widgets/arrow_back_Icon(1).dart';
import 'package:laqeetak/feature/view/home/home_view.dart';
import '../../model/loser_model.dart';
import 'loser_details_widget/custom_loser_details.dart';
import 'loser_details_widget/custom_loser_share_button.dart';
import 'loser_details_widget/custom_smooth_indicator.dart';
import 'loser_details_widget/custom_user_comment.dart';

class LostDetailsView extends StatefulWidget {
  final LoserItemModel item;

  const LostDetailsView({
    super.key,
    required this.item,
  });

  @override
  State<LostDetailsView> createState() => _LostDetailsViewState();
}

class _LostDetailsViewState extends State<LostDetailsView> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<String> userName = [
    'محمد علي',
    'محمد سيد',
    'كريم رجب',
    'يوسف علي',
  ];

  @override
  Widget build(BuildContext context) {
    final imagesLength = widget.item?.images.length ?? 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Stack(
            children: [
              /// page view for lost images
              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: (widget.item.images != null && widget.item.images!.isNotEmpty)
                      ? widget.item.images!.length
                      : 1,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    // نجيب رابط الصورة لو موجود وصالح
                    final imageUrl = (widget.item.images != null &&
                        widget.item.images!.isNotEmpty &&
                        widget.item.images![index].trim().isNotEmpty)
                        ? widget.item.images![index]
                        : null;

                    if (imageUrl == null) {
                      // لو مفيش صور أو الرابط فاضي
                      return Container(
                        color: AppColors.background,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 60.sp,
                          color: AppColors.captionColor,
                        ),
                      );
                    }

                    // لو فيه رابط صالح
                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      // لو فشل التحميل لأي سبب (404 أو النت فصل)
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.background,
                          child: Icon(
                            Icons.image_not_supported,
                            size: 60.sp,
                            color: AppColors.captionColor,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              ///  arrow back
              Positioned(
                top: 70.h,
                left: 15.w,
                child: CustomIconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColors.captionColor,
                  ),
                  onPressed: () {
                    AppNavigation.push(context, HomePageView());
                  },
                  shape: BoxShape.circle,
                ),
              ),

              /// smooth page indicator
              if (imagesLength > 0)
                CustomSmoothIndicator(
                  controller: _controller,
                  images: widget.item.images!,
                ),
            ],
          ),

          /// details section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
            child: CustomDetailsLoser(
              title: widget.item.title,
              date: widget.item.date,
              category: widget.item.category,
              location: widget.item.locationName,
              description: widget.item.description,
              commentsTitle: 'تعليقات',
            ),
          ),

          /// comments section
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              itemBuilder: (context, index) => CustomUserComment(
                userName: userName[index],
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: userName.length,
            ),
          ),
          /// share button
          CustomLoserShareButton(
            ownerID: widget.item.ownerId,
            postId: widget.item.itemId,
            itemTitle:widget.item.title,
            itemImage: widget.item.images.first,
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
