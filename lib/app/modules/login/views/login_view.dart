import 'package:flutter/material.dart';
import 'package:geek/app/widgets/custom_clipper.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: double.infinity,
              child: _buildInputFields(),
            )
          ],
        ),
      )
    );
  }
  Widget _buildInputFields(){
    return ClipPath(
      clipper: CustomClipperWidget(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffe18bff), Color(0xff7000FF)]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.002),
              Image(
                image: AssetImage("assets/images/logo_white.png"),
                height: Get.height * 0.2,
              ),
              Text("Login", style: TextStyle(
                color: Colors.white,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffe18bff), Color(0xff7000FF)]
        )
    ),
    child: Scaffold(
    backgroundColor: Colors.transparent,
    body: Stack(
    children: [
    Image(image: AssetImage("assets/images/logo_white.png"))
    ],
    ),
    ),*/