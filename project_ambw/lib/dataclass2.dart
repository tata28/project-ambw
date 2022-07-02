import 'package:cloud_firestore/cloud_firestore.dart';

class itemCategory {
  String itemId;
  final String category;

  itemCategory({
    required this.itemId,
    required this.category,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": itemId,
      "category": itemCategory,
    };
  }

  factory itemCategory.fromJson(Map<String, dynamic> json) {
    return itemCategory(
      itemId: json['id'],
      category: json['category'],
    );
  }

  void setId(String newID) {
    this.itemId = newID;
  }
}
