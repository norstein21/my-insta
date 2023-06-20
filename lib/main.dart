import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_instagram/app/modules/login/bindings/login_binding.dart';
import 'package:my_instagram/app/modules/login/views/login_view.dart';
import 'package:my_instagram/auth/auth_controller.dart';
import 'package:my_instagram/responsive/mobile_screen_layout.dart';
import 'package:my_instagram/responsive/responsive_layout_builder.dart';
import 'package:my_instagram/responsive/web_screen_layout.dart';
import 'package:my_instagram/utils/colors.dart';
import 'package:my_instagram/widget/dismiss_keyboard.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyAhYEzvThYbtAQ4rkBGsYZhmHnPwwXnUcs',
            messagingSenderId: '895058412892',
            projectId: 'my-insta-9f5b5',
            appId: '1:895058412892:web:0d817fe6401a77cd716d99',
            storageBucket: 'my-insta-9f5b5.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyIg());
}

class MyIg extends StatelessWidget {
  const MyIg({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GetMaterialApp(
          title: "MyInstagram",
          getPages: AppPages.routes,
          initialBinding: BindingsBuilder(() {
            Get.put<AuthController>(AuthController());
          }),
          debugShowCheckedModeBanner: false,
          home: GetBuilder<AuthController>(builder: (controller) {
            if (controller.status.isLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }

            // User tidak ditemukan / gagal auth
            if (controller.getUser == null) {
              LoginBinding().dependencies();
              return const LoginView();
            } else {
              return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return const ResponsiveLayout(
                            webScreenLayout: WebScreenLayout(),
                            mobileScreenLayout: MobileScreenLayout());
                      } else if (snapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("error : ${snapshot.error}"),
                          ),
                        );
                      }
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      LoginBinding().dependencies();
                      return const LoginView();
                    }
                  });
            }
          }),
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            }),
          )),
    );
  }
}
