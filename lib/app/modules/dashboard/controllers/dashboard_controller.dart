import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geek/app/modules/home/controllers/home_controller.dart';
import 'package:geek/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';
import '../../account/controllers/account_controller.dart';
import '../../index/controllers/index_controller.dart';

class DashboardController extends GetxController {
  final Rx<PageController> pageController = Rx<PageController>(PageController(initialPage: 1));
  HomeController homeController = Get.put(HomeController(), permanent: true);
  AccountController accountController = Get.put(AccountController(), permanent: true);
  IndexController indexController = Get.put(IndexController(), permanent: true);
  var tabIndex = 1.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    String status = StorageProvider.read(StorageKey.status);
    log("status : $status");
    if (status != "logged"){
      //Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTabIndex(int index) {
    pageController.value.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    update();
  }
}
