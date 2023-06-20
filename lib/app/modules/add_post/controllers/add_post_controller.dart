import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_instagram/resources/firestore_methods.dart';
import 'package:my_instagram/utils/utils.dart';

class AddPostController extends GetxController {
  // Uint8List? fileToPost;
  RxBool isLoading = false.obs;
  Rx<Uint8List?> fileToPost = Rx<Uint8List?>(null);
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // void postImage(String uid, String username, String profImage) async {
  //   String res = await FirestoreMethods().uploadPost(
  //       descriptionController.text, fileToPost.value!, uid, username, profImage);
  //   if (res == 'success') {
  //     Get.back();
  //   } else {
  //     Get.snackbar('Error', res);
  //   }
  // }

  void postImage(String uid, String username, String profImage) async {
    try {
      String res = await FirestoreMethods().uploadPost(
          descriptionController.text,
          fileToPost.value!,
          uid,
          username,
          profImage);
      if (res == 'success') {
        showSnackBar(Get.context!, 'Post berhasil ditambahkan');
      } else {
        showSnackBar(Get.context!, res);
      }
    } catch (e) {
      showSnackBar(Get.context!, e.toString());
    }
  }

  // Harus simple dialog dulu sebelum simple dialog option
  thisSelectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select Image'),
            children: [
              SimpleDialogOption(
                  child: const Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Camera')
                    ],
                  ),
                  onPressed: () async {
                    Uint8List? file = await pickImage(ImageSource.camera);
                    fileToPost.value = file;
                  }),
              SimpleDialogOption(
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Gallery')
                  ],
                ),
                onPressed: () async {
                  Uint8List file = await pickImage(ImageSource.gallery);
                  fileToPost.value = file;
                },
              ),
            ],
          );
        });
  }
}
