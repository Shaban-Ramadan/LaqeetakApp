import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String chatId;
  final String itemId;
  final String itemTitle;
  final String itemImage;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime? timestamp;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final bool isRead;


  ChatMessageModel({
    required this.chatId,
    required this.itemId,
    required this.itemTitle,
    required this.itemImage,
    required this.senderId,
    required this.receiverId,
    required this.message,
     this.timestamp,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId':chatId,
      'itemId': itemId,
      'itemTitle': itemTitle,
      'itemImage': itemImage,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': Timestamp.now(),
      'lastMessage': lastMessage,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'isRead': isRead

    };
  }
  factory ChatMessageModel.fromMap(String id, Map<String, dynamic> map) {
    return ChatMessageModel(
      chatId: id, // مهم ناخد الـ chatId من الـ id الممرر
      itemId: map['itemId'] ?? '',
      itemTitle: map['itemTitle'] ?? '',
      itemImage: map['itemImage'] ?? '',
      senderId: map['senderId'] ?? 'Unknown',
      receiverId: map['receiverId'] ?? 'Unknown',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : null,
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: map['lastMessageTime'] ?? Timestamp.now(),
      isRead: map['isRead'] ?? false,
    );
  }
}