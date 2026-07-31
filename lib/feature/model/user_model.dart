import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String userName;
  String useEmail;
  String usePhoneNumber;
  String useLocation;
  String usePassword;
  String useImage;

  UserModel({
    required this.userId,
    required this.userName,
    required this.useEmail,
    required this.usePhoneNumber,
    required this.useLocation,
    required this.usePassword,
    required this.useImage,
  });
   Map<String, dynamic> toJos() =>
       {
         'name': userName,
         'email': useEmail,
         'phoneNumber': usePhoneNumber,
         'location': useLocation,
         'password': usePassword,
         'image': useImage,
       };


  factory UserModel.fromJos(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userId: doc.id,
      userName: data['name'] ?? '',
      useEmail: data['email'] ?? '',
      usePhoneNumber: data['phoneNumber'] ?? '',
      useLocation: data['location'] ?? GeoPoint(0,0),
      usePassword: data['password'] ?? '',
      useImage: data['image'] ?? '',
    );
  }
}
