class LoserItemModel {
  String ownerId;
  String itemId;
  String title;
  String description;
  String category;
  String date;
  double latitude;
  double longitude;
  List<String> images;
  String locationName;

  LoserItemModel({
    required this.ownerId,
    required this.itemId,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId, // خليها متوافقة مع Firestore
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
      'images': images.join(','), // نخزن كمسار نصي مفصول بفواصل
    };
  }

  factory LoserItemModel.fromMap(Map<String, dynamic> map) {
    return LoserItemModel(
      itemId: map['itemId'] ,
      ownerId: map['ownerId'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      date: map['date'] ?? '',
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      locationName: map['locationName'] ?? '',
      images: map['images'] != null
          ? (map['images'] is String
              ? (map['images'] as String).split(',') // حولنا النص لـ List
              : List<String>.from(map['images']))
          : [],
    );
  }

  @override
  String toString() {
    return 'LoserItemModel(title: $title, category: $category, location: $locationName, imagesCount: ${images.length})';
  }
}
