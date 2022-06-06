import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ambw/dataclass.dart';

CollectionReference tblTask =
    FirebaseFirestore.instance.collection("tabelTask");

class Database {
  static Stream<QuerySnapshot> getData() {
    return tblTask.snapshots();
  }

  static Future<void> tambahData({required itemTask item}) async {
    DocumentReference docRef = tblTask.doc();
    print(docRef.id);
    item.itemId = docRef.id;
    await docRef
        .set(item.toJson())
        .whenComplete(() => print("data berhasil diinput"))
        .catchError((e) => print(e));
  }

  static Future<void> ubahData({required itemTask item}) async {
    DocumentReference docRef = tblTask.doc(item.itemId);
    await docRef
        .update(item.toJson())
        .whenComplete(() => print("data berhasil diubah"))
        .catchError((e) => print(e));
  }

  static Future<void> hapusData({required String idTask}) async {
    DocumentReference docRef = tblTask.doc(idTask);
    await docRef
        .delete()
        .whenComplete(() => print("data berhasil dihapus"))
        .catchError((e) => print(e));
  }
}
