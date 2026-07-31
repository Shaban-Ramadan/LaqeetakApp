import 'package:cloud_firestore/cloud_firestore.dart';

class MapGpsModel {
  String mapGpsId;
  double mapLatitude;
  double mapLongitude;
  String mapUserId;
  String? mapLoserId;
  Timestamp mapTimestamp;

  MapGpsModel({
    required this.mapGpsId,
    required this.mapLatitude,
    required this.mapLongitude,
    required this.mapUserId,
    this.mapLoserId,
    required this.mapTimestamp,
  });

  Map<String, dynamic> toJos() => {
    'latitude': mapLatitude,
    'longitude': mapLongitude,
    'userId': mapUserId,
    'loserId': mapLoserId,
    'timestamp': mapTimestamp,
  };

  factory MapGpsModel.fromJos(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MapGpsModel(
      mapGpsId: doc.id,
      mapLatitude: data['latitude']?.toDouble() ?? 0.0,
      mapLongitude: data['longitude']?.toDouble() ?? 0.0,
      mapUserId: data['userId'] ?? '',
      mapLoserId: data['loserId'],
      mapTimestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
