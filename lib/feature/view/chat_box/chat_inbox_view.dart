import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // لازم تضيف الحزمة
import 'package:laqeetak/coure/utils/app_anigation(1).dart';
import 'package:laqeetak/feature/view_model/chat_box_cubit/chat_box_cubit.dart';
import '../../model/chat_model.dart';
import 'chat_obx_view.dart';

class InboxScreen extends StatelessWidget {
  final String postId;
  final String ownerId;
  final String itemTitle;
  final String itemImage;

  const InboxScreen({
    super.key,
    required this.postId,
    required this.ownerId,
    required this.itemTitle,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inbox",
          style: TextStyle(fontSize: 20.sp), // responsive text
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('chats')
            .doc(postId)
            .collection('messages')
            .where('receiverId', isEqualTo: ownerId)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "لا يوجد رسائل بعد",
                style: TextStyle(fontSize: 18.sp),
              ),
            );
          }

          final messages = snapshot.data!.docs.map((doc) {
            return ChatMessageModel.fromMap(
              postId,
              doc.data() as Map<String, dynamic>,
            );
          }).toList();

          final groupedMessages = <String, List<ChatMessageModel>>{};
          for (final msg in messages) {
            groupedMessages.putIfAbsent(msg.senderId, () => []);
            groupedMessages[msg.senderId]!.add(msg);
          }

          final senders = groupedMessages.entries.toList();
          senders.sort((a, b) {
            final aTime = a.value.first.timestamp ?? DateTime(0);
            final bTime = b.value.first.timestamp ?? DateTime(0);
            return aTime.compareTo(bTime);
          });

          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: senders.length,
            separatorBuilder: (_, __) => Divider(height: 1.h),
            itemBuilder: (context, index) {
              final senderId = senders[index].key;
              final msgs = senders[index].value;

              // ترتيب الرسائل داخل كل محادثة من الأقدم للأحدث
              msgs.sort(
                      (a, b) => (a.timestamp ?? DateTime(0))
                      .compareTo(b.timestamp ?? DateTime(0)));

              final lastMessage = msgs.last.message;
              final unreadCount =
                  msgs.where((m) => m.receiverId == ownerId && !m.isRead).length;
              final lastMessageTime =
              msgs.last.timestamp != null ? _formatTime(msgs.last.timestamp!) : '';

              return ListTile(
                leading: CircleAvatar(
                  radius: 22.r, // responsive radius
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    senderId.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                title: Text(
                  senderId,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                subtitle: Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp),
                ),
                trailing: SizedBox(
                  width: 50.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          lastMessageTime,
                          style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          margin: EdgeInsets.only(top: 4.h),
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                    ],
                  ),
                ),
                onTap: () => _openChat(context, senderId),
              );
            },
          );
        },
      ),
    );
  }

  void _openChat(BuildContext context, String receiverId) {
    if (receiverId.trim().isEmpty) return;

    AppNavigation.push(
      context,
      BlocProvider(
        create: (context) => ChatCubit(),
        child: ChatScreen(
          receiverId: receiverId,
          itemId: postId,
          itemTitle: itemTitle,
          itemImage: itemImage,
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}