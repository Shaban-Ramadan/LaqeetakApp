import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqeetak/feature/model/loser_model.dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import '../../../../coure/widgets/arrow_back_Icon(1).dart';
import '../../loser/loser_details_widget/custom_loser_share_button.dart';

class CustomPosterWidget extends StatelessWidget {
  final LoserItemModel loserItemModel;
 final int index ;
  const CustomPosterWidget({
   required this.loserItemModel,
   required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoserCubit cubit =LoserCubit.get(context);
    return SizedBox(
      height: 283.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: loserItemModel.images !=null && loserItemModel.images.isNotEmpty
                ? Image.network(
              loserItemModel.images.first,
                    height: 283.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 283.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50.sp,
                      color: Colors.grey[600],
                    ),
                  ),
          ),

          /// زر المشاركة في الأسفل
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15.h),
              child: CustomLoserShareButton(
                ownerID: loserItemModel.ownerId,
                postId: loserItemModel.itemId,
                itemTitle: loserItemModel.title,
                itemImage: loserItemModel.images.first,
              ),
            ),
          ),

          /// زر المزيد في الأعلى
          Positioned(
            top: 15.h,
            left: 15.w,
            child:CustomIconButton(
              icon: Icon(
                cubit.isClickList[index] ? Icons.delete : Icons.more_vert,
                size: 20.sp,
              ),
              onPressed: () {
                if (cubit.isClickList[index]) {
                  cubit.deletePost(index);
                } else {
                  cubit.toGallClick(index);
                }
              },
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
