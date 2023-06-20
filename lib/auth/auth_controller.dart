import 'package:my_instagram/models/user.dart' as model;

import 'package:get/get.dart';
import 'package:my_instagram/resources/auth_methods.dart';

class AuthController extends GetxController with StateMixin {
  model.User? _user;
  final AuthMethods _authMethods = AuthMethods();
  RxBool isLoading = true.obs;

  model.User? get getUser => _user;

  @override
  void onInit() async {
    super.onInit();
    await refreshUser();
  }

  Future<bool> refreshUser() async {
    // Make status to loading
    change(null, status: RxStatus.loading());
    model.User? user = await _authMethods.getUserDetails();
    _user = user;
    isLoading(false);
    if (user == null) {
      change(null, status: RxStatus.success());
      return false;
    }
    update();
    change(null, status: RxStatus.success());
    return true;
    // Done change status to success
  }
}
