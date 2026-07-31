import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/chat_model.dart';
import 'chat_box_states.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of<ChatCubit>(context);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> sendMessage({
    required String itemId,
    required String senderId,
    required String receiverId,
    required String messageText,
    required String itemTitle,
    required String itemImage,
  }) async {

    emit(ChatLoading());

    try {

      // ترتيب المستخدمين لتوليد chatId ثابت
      final ids = [senderId, receiverId]..sort();
      final chatId = "${itemId}_${ids[0]}_${ids[1]}";

      final chatDocRef = firestore.collection('chats').doc(chatId);

      final chatDoc = await chatDocRef.get();

      // لو الشات غير موجود يتم إنشاؤه
      if (!chatDoc.exists) {
        await chatDocRef.set({
          'chatId': chatId,
          'itemId': itemId,
          'itemTitle': itemTitle,
          'itemImage': itemImage,
          'participants': ids,
          'lastMessage': messageText,
          'lastMessageTime': FieldValue.serverTimestamp(),
          'unreadCount_$receiverId': 0,
          'unreadCount_$senderId': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // إنشاء الرسالة
      final message = ChatMessageModel(
        chatId: chatId,
        itemId: itemId,
        itemTitle: itemTitle,
        itemImage: itemImage,
        senderId: senderId,
        receiverId: receiverId,
        message: messageText,
        lastMessage: messageText,
        lastMessageTime: Timestamp.now(),
        isRead: false,
      );

      // رفع الرسالة
      await chatDocRef.collection('messages').add(message.toMap());

      // تحديث بيانات الشات
      await chatDocRef.update({
        'lastMessage': messageText,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'unreadCount_$receiverId': FieldValue.increment(1),
      });

      emit(ChatSent());

    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

// Stream الرسائل
  Stream<List<ChatMessageModel>> getMessages(String chatId) {
    try {
      return firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatMessageModel.fromMap(chatId, doc.data()))
              .toList());
    } catch (e) {
      emit(ChatError(e.toString()));
      return const Stream.empty();
    }
  }
}
