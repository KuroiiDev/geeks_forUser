import 'dart:developer';

import 'package:geek/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';
import '../../account/controllers/account_controller.dart';
import '../../index/controllers/index_controller.dart';

class DashboardController extends GetxController {
  HomeController homeController = Get.put(HomeController(), permanent: true);
  AccountController accountController = Get.put(AccountController(), permanent: true);
  IndexController indexController = Get.put(IndexController(), permanent: true);
  var tabIndex = 1;

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
    tabIndex = index;
    update();
  }
}
