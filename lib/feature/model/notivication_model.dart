import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String notificationId;
  String notificationTitle;
  String notificationBody;
  String notificationUserId;
  String? notificationLoserId;
  Timestamp notificationTimestamp;
  bool notificationRead;

  NotificationModel({
    required this.notificationId,
    required this.notificationTitle,
    required this.notificationBody,
    required this.notificationUserId,
    this.notificationLoserId,
    required this.notificationTimestamp,
    required this.notificationRead,
  });

  Map<String, dynamic> toJos() => {
    'title': notificationTitle,
    'body': notificationBody,
    'userId': notificationUserId,
    'loserId': notificationLoserId,
    'timestamp': notificationTimestamp,
    'read': notificationRead,
  };

  factory NotificationModel.fromJos(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      notificationId: doc.id,
      notificationTitle: data['title'] ?? '',
      notificationBody: data['body'] ?? '',
      notificationUserId: data['userId'] ?? '',
      notificationLoserId: data['loserId'],
      notificationTimestamp: data['timestamp'] ?? Timestamp.now(),
      notificationRead: data['read'] ?? false,
    );
  }
}
