import 'package:cloud_firestore/cloud_firestore.dart';

class itemTask {
  String itemId;
  final String itemTitle;
  final String itemDetail;
  final String itemCategory;
  final bool itemDone;
  final Timestamp itemTime;

  itemTask(
      {required this.itemId,
      required this.itemTitle,
      required this.itemDetail,
      required this.itemCategory,
      required this.itemDone,
      required this.itemTime});
  Map<String, dynamic> toJson() {
    return {
      "id": itemId,
      "title": itemTitle,
      "detail": itemDetail,
      "category": itemCategory,
      "done": itemDone,
      "time": itemTime
    };
  }

  factory itemTask.fromJson(Map<String, dynamic> json) {
    return itemTask(
        itemId: json['id'],
        itemTitle: json['title'],
        itemDetail: json['detail'],
        itemCategory: json['category'],
        itemDone: json['done'],
        itemTime: json['time']);
  }

  void setId(String newID) {
    this.itemId = newID;
  }
}
