import 'package:my_instagram/models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_instagram/resources/auth_methods.dart';

class AuthController extends GetxController {
  model.User? _user;
  final AuthMethods _authMethods = AuthMethods();
  RxBool isLoading = true.obs;

  model.User? get getUser => _user;

  @override
  void onInit() async {
    super.onInit();
    await refreshUser();
    print(getUser);
  }

  Future<void> refreshUser() async {
    model.User user = await _authMethods.getUserDetails();
    _user = user;
    isLoading(false);
    update();
  }
}
