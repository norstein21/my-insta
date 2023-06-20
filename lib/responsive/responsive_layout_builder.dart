import 'package:flutter/material.dart';
import 'package:my_instagram/utils/global_varible.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= webScreenSize) {
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}


  // final Widget mobile;
  // final Widget? tablet;
  // final Widget desktop;

  // const ResponsiveLayout({
  //   Key? key,
  //   required this.mobile,
  //   this.tablet,
  //   required this.desktop
  // }) : super(key: key);

  // static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < webScreenSize;
  // static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= webScreenSize && MediaQuery.of(context).size.width < 900;
  // static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 900;

  // @override
  // Widget build(BuildContext context){
  //   return LayoutBuilder(
  //     builder: (context, constraints){
  //       if(constraints.maxWidth >= 900){
  //         return desktop;
  //       }else if(constraints.maxWidth >= webScreenSize && tablet != null){
  //         return tablet!;
  //       }else{
  //         return mobile;
  //       }
  //     },
  //   );
