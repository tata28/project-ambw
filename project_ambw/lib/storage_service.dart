// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class Storage {
//   final firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;

//   Future<firebase_storage.ListResult> listFiles() async {
//     firebase_storage.ListResult results =
//         await storage.ref('/musics').listAll();

//     results.items.forEach((firebase_storage.Reference ref) {
//       print('Found file:$ref');
//     });

//     return results;
//   }
// }
