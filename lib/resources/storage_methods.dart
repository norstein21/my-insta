import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost, String uid) async {
    String res = "Terjadi error, silahkan coba lagi";
    try {
      if (file.isNotEmpty) {
        //mengupload gambar ke firebase storage
        TaskSnapshot snapshot =
            await _storage.ref().child(childName).child(uid).putData(file);
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
