import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsive
import '../../../coure/utils/app_colors.dart';
import '../../model/chat_model.dart';
import '../../view_model/chat_box_cubit/chat_box_cubit.dart';
import '../../view_model/chat_box_cubit/chat_box_states.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String itemId;
  final String itemTitle;
  final String itemImage;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.itemId,
    required this.itemTitle,
    required this.itemImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  late String chatId;
  late String currentUserId;

  @override
  void initState() {
    super.initState();

    currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final ids = [currentUserId, widget.receiverId]..sort();
    chatId = "${widget.itemId}_${ids[0]}_${ids[1]}";

    _resetUnreadCount();
  }

  void _resetUnreadCount() async {
    final chatRef = FirebaseFirestore.instance.collection('chats').doc(chatId);
    final doc = await chatRef.get();

    if (doc.exists) {
      await chatRef.update({'unreadCount_$currentUserId': 0});
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    ChatCubit.get(context).sendMessage(
      itemId: widget.itemId,
      senderId: currentUserId,
      receiverId: widget.receiverId,
      messageText: messageController.text.trim(),
      itemTitle: widget.itemTitle,
      itemImage: widget.itemImage,
    );

    messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "المحادثة",
                style: TextStyle(fontSize: 20.sp),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                /// item info
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
            child: (widget.itemImage != null && widget.itemImage.isNotEmpty)
                ? Image.network(
              widget.itemImage,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
              // لو الصورة فشلت في التحميل لأي سبب
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50.w,
                  height: 50.h,
                  color: AppColors.background,
                  child: Icon(
                    Icons.image_not_supported,
                    color: AppColors.captionColor,
                    size: 30.r,
                  ),
                );
              },
            )
                : Container(
              width: 50.w,
              height: 50.h,
              color: AppColors.background,
              child: Icon(
                Icons.image_not_supported,
                color: AppColors.captionColor,
                size: 30.r,
              ),
            ),
          ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          widget.itemTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// messages
                Expanded(
                  child: StreamBuilder<List<ChatMessageModel>>(
                    stream: ChatCubit.get(context).getMessages(chatId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final messages = snapshot.data!;

                      /// Sort messages from oldest to newest
                      messages.sort((a, b) =>
                          (a.timestamp ?? DateTime(0))
                              .compareTo(b.timestamp ?? DateTime(0)));

                      // Scroll to bottom after build
                      _scrollToBottom();

                      return ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final isMe = msg.senderId == currentUserId;

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              decoration: BoxDecoration(
                                color: isMe ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg.message,
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    msg.timestamp != null
                                        ? "${msg.timestamp!.hour.toString().padLeft(2,'0')}:${msg.timestamp!.minute.toString().padLeft(2,'0')}"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: isMe ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                /// send message
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: "اكتب رسالتك...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, size: 28.r),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}