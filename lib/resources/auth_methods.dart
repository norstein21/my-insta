import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_instagram/models/user.dart' as model;
import 'package:my_instagram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ValueNotifier<bool> isSuccess = ValueNotifier<bool>(false);

  // get user detail
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot dataUser =
        await _firestore.collection('users').doc(currentUser.uid).get();
    print(dataUser);
    return model.User.fromSnap(dataUser);

    // try {
    //   DocumentSnapshot dataUser =
    //       await _firestore.collection('users').doc(currentUser.uid).get();
    //   return model.User.fromSnap(dataUser);
    // } catch (e) {
    //   print(e.toString());
    //   return user;
    // }
  }

  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List profileImage}) async {
    String res = "Terjadi error, silahkan coba lagi";
    isSuccess = ValueNotifier<bool>(false);
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        //mendaftarkan user ke firebase
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print('uid = ${userCredential.user!.uid}');

        String photoUrl = await StorageMethods().uploadImageToStorage(
            'profilePics', profileImage, false, userCredential.user!.uid);
        //menambah user ke dalam database
        model.User user = model.User(
            uid: userCredential.user!.uid,
            username: username,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            profileImage: photoUrl);

        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toMap());
        isSuccess = ValueNotifier<bool>(true);
        res = "Berhasil mendaftarkan user";
      }
    } on FirebaseAuthException catch (e) {
      res = e.message!;
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Terjadi error, silahkan coba lagi";
    isSuccess = ValueNotifier<bool>(false);
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        //mendaftarkan user ke firebase
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Berhasil login";
        isSuccess = ValueNotifier<bool>(true);
      } else {
        res = "Email atau password tidak boleh kosong";
      }
    } on FirebaseAuthException catch (e) {
      res = e.message!;
    }
    return res;
  }
}
