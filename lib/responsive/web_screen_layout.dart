import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_instagram/auth/auth_controller.dart';
import 'package:my_instagram/models/user.dart' as model;

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  model.User? _user = Get.find<AuthController>().getUser;

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   print(snap.data());
  //   user = model.User.fromSnap(snap);
  //   setState(() {
  //     username = user!.email;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${_user!.email}')),
    );
  }
}
