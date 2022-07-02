import 'package:cloud_firestore/cloud_firestore.dart';
import 'dataclass2.dart';

CollectionReference tblCategory =
    FirebaseFirestore.instance.collection("tabelCategory");

class Database2 {
  static Stream<QuerySnapshot> getData() {
    return tblCategory.snapshots();
  }

  static Future<void> tambahData({required itemCategory item}) async {
    DocumentReference docRef = tblCategory.doc(item.itemId);
    //print(docRef.id);
    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<void> ubahData({required itemCategory item}) async {
    DocumentReference docRef = tblCategory.doc(item.itemId);
    await docRef
        .update(item.toJson())
        .whenComplete(() => print("data berhasil diubah"))
        .catchError((e) => print(e));
  }

  static Future<void> hapusData({required String idCategory}) async {
    DocumentReference docRef = tblCategory.doc(idCategory);
    await docRef
        .delete()
        .whenComplete(() => print("data berhasil dihapus"))
        .catchError((e) => print(e));
  }
}
