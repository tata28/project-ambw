import 'package:cloud_firestore/cloud_firestore.dart';

class itemCategory {
  String idItem;
  final String category;

  itemCategory({
    required this.idItem,
    required this.category,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": idItem,
      "category": itemCategory,
    };
  }

  factory itemCategory.fromJson(Map<String, dynamic> json) {
    return itemCategory(
      idItem: json['id'],
      category: json['category'],
    );
  }

  void setId(String newID) {
    this.idItem = newID;
  }
}
