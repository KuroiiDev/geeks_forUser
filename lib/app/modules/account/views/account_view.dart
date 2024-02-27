import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_navbar.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [

          ],
        ),
        bottomNavigationBar: CustomNavbar(indexNum: 2)
    );
  }
}
