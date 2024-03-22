import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Icon(Icons.logout),
          onPressed: ()=>controller.logout(),
        )
      ),
    );
  }
}
