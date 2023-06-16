import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_instagram/responsive/mobile_screen_layout.dart';
import 'package:my_instagram/responsive/responsive_layout_builder.dart';
import 'package:my_instagram/responsive/web_screen_layout.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        webScreenLayout: WebScreenLayout(),
        mobileScreenLayout: MobileScreenLayout());
  }
}
