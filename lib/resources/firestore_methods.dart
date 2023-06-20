import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_instagram/models/post.dart';
import 'package:my_instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Terjadi error, silahkan coba lagi";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true, uid);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          postUrl: photoUrl,
          uid: uid,
          username: username,
          profileImage: profImage,
          datePublished: DateTime.now(),
          postId: postId,
          likes: []);

      await _firestore.collection('posts').doc(postId).set(post.toMap());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
