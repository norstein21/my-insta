import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_instagram/resources/auth_methods.dart';
import 'package:my_instagram/responsive/mobile_screen_layout.dart';
import 'package:my_instagram/responsive/responsive_layout_builder.dart';
import 'package:my_instagram/responsive/web_screen_layout.dart';
import 'package:my_instagram/utils/utils.dart';

class LoginController extends GetxController {
  // bool untuk mengecek sedang loading atau tidak
  RxBool isLoading = false.obs;

  Future<String> login() async {
    String res = "Terjadi error, silahkan coba lagi";
    isLoading.value = true;
    try {
      res = await AuthMethods().loginUser(
          email: emailTextController.text,
          password: passwordTextController.text);
      if (AuthMethods().isSuccess.value) {
        Get.off(MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout())));
      } else {
        showSnackBar(Get.context!, res);
      }
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    } finally {
      isLoading.value = false;
    }
  }

  // Text Controller untuk Login
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
}
