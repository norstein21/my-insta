import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_instagram/app/routes/app_pages.dart';
import 'package:my_instagram/utils/colors.dart';
import 'package:my_instagram/widget/text_field_input.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              Image.asset(
                'assets/ic_pertalife.png',
                height: 100,
              ),

              const SizedBox(height: 64),
              // create a text field input widget for email
              WidgetTextFieldInput(
                  labelText: 'Email',
                  hintText: 'Masukkan email anda',
                  controller: controller.emailTextController,
                  textInputType: TextInputType.emailAddress),

              const SizedBox(height: 20),
              // create a text field input widget for password
              WidgetTextFieldInput(
                  labelText: 'Password',
                  hintText: 'Masukkan password anda',
                  isPass: true,
                  controller: controller.passwordTextController,
                  textInputType: TextInputType.text),
              const SizedBox(height: 20),
              // create a login button widget
              SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.login,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Login')),
                  )),
              Flexible(flex: 2, child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap: () => Get.offAndToNamed(Routes.REGISTER),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
