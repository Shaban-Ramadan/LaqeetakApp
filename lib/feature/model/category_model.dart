import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String categoryId;
  bool all;
  bool mobiles;
  bool wallet;
  bool clocks;
  bool keys;

  CategoryModel({
    required this.categoryId,
    required this.all,
    required this.mobiles,
    required this.wallet,
    required this.clocks,
    required this.keys,
  });

  Map<String, dynamic> toJos() => {
    'all': all,
    'mobiles': mobiles,
    'wallet': wallet,
    'clocks': clocks,
    'keys': keys,
  };

  factory CategoryModel.fromJos(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      categoryId: doc.id,
      all: data['all'] ?? false,
      mobiles: data['mobiles'] ?? false,
      wallet: data['wallet'] ?? false,
      clocks: data['clocks'] ?? false,
      keys: data['keys'] ?? false,
    );
  }
}
