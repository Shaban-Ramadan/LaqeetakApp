import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String adminId;
  String adminName;
  String adminEmail;
  String adminPassword;

  AdminModel({
    required this.adminId,
    required this.adminName,
    required this.adminEmail,
    required this.adminPassword,
  });

  Map<String, dynamic> toJos() => {
    'name': adminName,
    'email': adminEmail,
    'password': adminPassword,
  };

  factory AdminModel.fromJos(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AdminModel(
      adminId: doc.id,
      adminName: data['name'] ?? '',
      adminEmail: data['email'] ?? '',
      adminPassword: data['password'] ?? '',
    );
  }
}
