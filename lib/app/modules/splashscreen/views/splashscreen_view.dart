import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 5700), (() => Get.offAllNamed(Routes.LOGIN))
    );
    return SafeArea(
      child: Container(
          child: Center(
          child: Lottie.asset("splash/splash_screen2.json"),
      ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff8c68ab), Color(0xff7155ff)]
            ),
        ),
      ),
    );
  }
}
