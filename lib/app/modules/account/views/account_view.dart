import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: FloatingActionButton.small(
              onPressed: () => controller.logout(),
              child: Icon(Icons.logout, color: GlobalColor.title),
              backgroundColor: Color(0xfff3f3f3),
              elevation: 0,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff7055f8), Color(0xffe3dbff), Color(0xfff3f3f3)]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: controller.obx((state) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  height: Get.width*0.45,
                  width: Get.width*0.45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 5),
                    shape: BoxShape.circle
                  ),
                ),
              ),
              Text(state?.email ?? '-')
            ],
          ),
        ),
      )
    ));
  }
}
