import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
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

  void increment() => count.value++;
}
