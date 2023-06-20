import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_instagram/app/modules/add_post/bindings/add_post_binding.dart';
import 'package:my_instagram/auth/auth_controller.dart';
import 'package:my_instagram/models/user.dart';
import 'package:my_instagram/utils/colors.dart';
import 'package:my_instagram/utils/textstyle.dart';

import '../controllers/add_post_controller.dart';

class AddPostView extends StatefulWidget {
  final PageController pageController;
  const AddPostView({Key? key, required this.pageController}) : super(key: key);

  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  late AddPostController controller;
  User? user = Get.find<AuthController>().getUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddPostBinding().dependencies();
    controller = Get.find<AddPostController>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<AddPostController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post to'),
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            widget.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton(
              onPressed: () {
                controller.postImage(
                    user!.uid, user!.username, user!.profileImage);
              },
              child: Text(
                'Post',
                style: TextApp().setTextRoboto(16, blueColor, FontWeight.bold),
              ))
        ],
      ),
      body: Obx(
        () => controller.fileToPost.value == null
            ? Center(
                child: IconButton(
                  onPressed: () => controller.thisSelectImage(context),
                  icon: const Icon(Icons.add_a_photo),
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(user!.profileImage)),
                      SizedBox(
                        width: Get.width * 0.4,
                        child: TextFormField(
                          controller: controller.descriptionController,
                          decoration: const InputDecoration(
                              hintText: 'Write a caption...',
                              border: InputBorder.none),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.memory(controller.fileToPost.value!)),
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () => controller.thisSelectImage(context),
                      child: Text('Select Image'))
                ],
              ),
      ),
    );
  }
}
