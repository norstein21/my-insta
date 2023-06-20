import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_instagram/app/modules/add_post/views/add_post_view.dart';
import 'package:my_instagram/utils/colors.dart';
import 'package:my_instagram/utils/global_varible.dart';

import '../auth/auth_controller.dart';
import '../models/user.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _navbarIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _navbarIndex);
    _pageController.addListener(() {
      setState(() {
        _navbarIndex = _pageController.page!.toInt();
      });
    });
  }

  void navigationTapped(int page) {
    setState(() {
      _navbarIndex = page;
    });
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Get.find<AuthController>().getUser;
    return Scaffold(
        body: SafeArea(
            child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(child: Text(user!.username)),
            Center(child: Text(user.email)),
            AddPostView(
              pageController: _pageController,
            ),
            Center(child: Text(user.uid)),
            Center(child: Text(user.profileImage))
          ],
        )),
        bottomNavigationBar: CupertinoTabBar(
            currentIndex: _navbarIndex,
            onTap: navigationTapped,
            activeColor: primaryColor,
            backgroundColor: mobileBackgroundColor,
            items: bottomNavbarItem));
  }
}
