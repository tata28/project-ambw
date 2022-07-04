import 'package:cloud_firestore/cloud_firestore.dart';

class itemUser {
  final String itemUsername;
  final String itemPassword;

  itemUser({required this.itemUsername, required this.itemPassword});
  Map<String, dynamic> toJson() {
    return {
      "username": itemUsername,
      "password": itemPassword,
    };
  }

  factory itemUser.fromJson(Map<String, dynamic> json) {
    return itemUser(
      itemUsername: json['username'],
      itemPassword: json['password'],
    );
  }

  // void setId(String newID) {
  //   this.itemId = newID;
  // }
}
