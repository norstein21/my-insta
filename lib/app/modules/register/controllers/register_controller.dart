import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_instagram/resources/auth_methods.dart';
import 'package:my_instagram/utils/utils.dart';

class RegisterController extends GetxController {
  // Loading state saat submit
  RxBool isLoading = false.obs;

  // Text Controller untuk Registrasi
  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController usernameRegisterController = TextEditingController();
  TextEditingController bioRegisterController = TextEditingController();

  // Menampung image yang dipilih oleh User
  final selectedImage = Rx<Uint8List?>(null);

  // Fungsi untuk mengganti image yang telah diupload user
  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    selectedImage.value = image;
  }

  // Fungsi untuk registrasi
  void signUp() async {
    isLoading(true);
    String res = await AuthMethods().signUpUser(
        email: emailRegisterController.text,
        password: passwordRegisterController.text,
        username: usernameRegisterController.text,
        bio: bioRegisterController.text,
        profileImage: selectedImage.value!);
    if (AuthMethods().isSuccess.value) {
      showSnackBar(Get.context!, res);
      isLoading(false);
    } else {
      showSnackBar(Get.context!, res);
      isLoading(false);
    }
  }
}
