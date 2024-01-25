import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffe18bff), Color(0xff7000FF)]
        )
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