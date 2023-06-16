import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_instagram/app/routes/app_pages.dart';
import 'package:my_instagram/resources/auth_methods.dart';
import 'package:my_instagram/utils/colors.dart';
import 'package:my_instagram/utils/utils.dart';
import 'package:my_instagram/widget/text_field_input.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  Uint8List? profileImage;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());

    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Container(), flex: 2),
          // //create widget svg
          // SvgPicture.asset(
          //   'assets/ic_instagram.svg',
          //   // ignore: deprecated_member_use
          //   color: primaryColor,
          //   height: 64,
          // ),
          Image.asset(
            'assets/ic_pertalife.png',
            height: 100,
          ),

          const SizedBox(height: 34),

          //stack widget contains circle avatar and camera icon
          Stack(
            children: [
              //create circle avatar
              Obx(
                () => controller.selectedImage.value != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            MemoryImage(controller.selectedImage.value!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://www.kindpng.com/picc/m/421-4212275_transparent-default-avatar-png-avatar-img-png-download.png'),
                      ),
              ),
              //create camera icon
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () {
                      controller.selectImage();
                    }),
              )
            ],
          ),
          const SizedBox(height: 24),

          // create a text field input widget for email
          WidgetTextFieldInput(
              labelText: 'Username',
              hintText: 'Masukkan username anda',
              controller: controller.usernameRegisterController,
              textInputType: TextInputType.emailAddress),

          const SizedBox(height: 20),
          // create a text field input widget for password
          WidgetTextFieldInput(
              labelText: 'Email',
              hintText: 'Masukkan email anda',
              controller: controller.emailRegisterController,
              textInputType: TextInputType.text),
          const SizedBox(height: 20),
          WidgetTextFieldInput(
              labelText: 'Password',
              hintText: 'Masukkan password anda',
              isPass: true,
              controller: controller.passwordRegisterController,
              textInputType: TextInputType.text),
          const SizedBox(height: 20),
          WidgetTextFieldInput(
              labelText: 'Bio',
              hintText: 'Masukkan bio anda',
              controller: controller.bioRegisterController,
              textInputType: TextInputType.text),
          const SizedBox(height: 20),
          // create a login button widget
          SizedBox(
            width: double.infinity,
            height: 55,
            child: Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  // padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Register',
                        style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.LOGIN),
                  child: const Text(
                    'Login',
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
