import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost, String uid) async {
    String res = "Terjadi error, silahkan coba lagi";

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String uuid = const Uuid().v1();
      ref = ref.child(uuid);
    }

    try {
      if (file.isNotEmpty) {
        //mengupload gambar ke firebase storage
        TaskSnapshot snapshot = await ref.putData(file);
        //mengambil url gambar
        String downloadUrl = await snapshot.ref.getDownloadURL();
        res = downloadUrl;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
