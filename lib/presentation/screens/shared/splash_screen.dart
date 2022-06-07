import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/constants/paths.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, LoginScreen.loginRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Image.asset(
        Paths.splashLogoImage,
        height: 20.h,
      )),
      color: AppColor.white,
    );
  }
}
