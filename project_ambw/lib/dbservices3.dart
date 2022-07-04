import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ambw/dataclass.dart';

import 'dataclass3.dart';

CollectionReference tblUser =
    FirebaseFirestore.instance.collection("tabelUser");

class Database3 {
  static Stream<QuerySnapshot> getData() {
    return tblUser.snapshots();
  }

  static Future<void> tambahData({required itemUser item}) async {
    DocumentReference docRef = tblUser.doc(item.itemUsername);
    // print(docRef.id);
    // item.itemId = docRef.id;
    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  // static Future<void> ubahData({required itemUser item}) async {
  //   DocumentReference docRef = tblUser.doc(item.itemId);
  //   await docRef
  //       .update(item.toJson())
  //       .whenComplete(() => print("data berhasil diubah"))
  //       .catchError((e) => print(e));
  // }

  // static Future<void> hapusData({required String idUser}) async {
  //   DocumentReference docRef = tblUser.doc(idUser);
  //   await docRef
  //       .delete()
  //       .whenComplete(() => print("data berhasil dihapus"))
  //       .catchError((e) => print(e));
  // }

  //  Future<QuerySnapshot> login({required itemUser item}) async {
  //   // DocumentReference docRef = tblUser.doc(item.itemUsername);
  //   // await docRef
  //   //     .update(item.toJson())
  //   //     .whenComplete(() => print("data berhasil diubah"))
  //   //     .catchError((e) => print(e));

  //   return FirebaseFirestore.instance
  //       .collection("tabelUser")
  //       .where("username", isEqualTo: item.itemUsername)
  //       .where("password", isEqualTo: item.itemPassword)
  //       .snapshots();
  // }
}
