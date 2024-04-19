import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 3000), (() => Get.offAllNamed(Routes.LOGIN))
    );
    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(0.5),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff8c68ab), Color(0xff7155ff)]
            ),
        ),
          child: Center(
          child: ClipOval(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset("assets/images/logo_white.png"),
              )
          ),
      ),
      ),
    );
  }
}
