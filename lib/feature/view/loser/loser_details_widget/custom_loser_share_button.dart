import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../coure/utils/app_anigation(1).dart';
import '../../../../coure/utils/app_colors.dart';
import '../../../../coure/utils/sytles.dart';
import '../../../view_model/chat_box_cubit/chat_box_cubit.dart';
import '../../chat_box/chat_inbox_view.dart';
import '../../chat_box/chat_obx_view.dart';

class CustomLoserShareButton extends StatelessWidget {
  final String ownerID;
  final String postId;
  final String itemTitle;
  final String itemImage;

  const CustomLoserShareButton({
    super.key,
    required this.ownerID,
    required this.postId,
    required this.itemTitle,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 13.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'مشاركة',
                style: AppTextStyles.subHeading.copyWith(
                  color: AppColors.primary,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Icon(
              Icons.share,
              color: AppColors.primary,
              size: 20.sp,
            ),
            const Spacer(),

            // Stack حوالين زر الوارد / المراسلة
            Stack(
              clipBehavior: Clip.none,
              children: [
                TextButton(
                  onPressed: () {
                    if (currentUserId == ownerID) {
                      if (postId.isNotEmpty && ownerID.isNotEmpty) {
                        AppNavigation.push(
                          context,
                          InboxScreen(
                            postId: postId,
                            ownerId: ownerID,
                            itemTitle: itemTitle,
                            itemImage: itemImage,
                          ),
                        );
                      }
                    } else {
                      if (postId.isNotEmpty && ownerID.isNotEmpty) {
                        AppNavigation.push(
                          context,
                          BlocProvider(
                            create: (context) => ChatCubit(),
                            child: ChatScreen(
                              receiverId: ownerID,
                              itemId: postId,
                              itemTitle: itemTitle,
                              itemImage: itemImage,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    currentUserId == ownerID ? 'الوارد' : 'مراسلة',
                    style: AppTextStyles.subHeading.copyWith(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                if (currentUserId == ownerID)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .doc(postId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return SizedBox();
                        final data =
                            snapshot.data!.data() as Map<String, dynamic>?;
                        final unread = data?['unreadCount_$currentUserId'] ?? 0;
                        return unread > 0
                            ? CircleAvatar(
                                radius: 6.r,
                                backgroundColor: Colors.red,
                                child: Text(
                                  '$unread',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : SizedBox();
                      },
                    ),
                  ),
              ],
            ),

            Icon(
              currentUserId == ownerID ? Icons.inbox : Icons.comment,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ],
        ));
  }
}
