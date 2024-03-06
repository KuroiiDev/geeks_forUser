import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final TextEditingController searchController = TextEditingController();
  RxString name = "".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    name = StorageProvider.read(StorageKey.name).obs;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    name = StorageProvider.read(StorageKey.name).obs;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  search() async{
    FocusScope.of(Get.context!).unfocus();
    Get.snackbar("Search", searchController.text.toString(), backgroundColor: Colors.green);
  }
}
