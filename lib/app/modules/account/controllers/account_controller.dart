import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class AccountController extends GetxController {
  //TODO: Implement AccountController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  logout() async{
    await StorageProvider.write(StorageKey.idUser, "");
    await StorageProvider.write(StorageKey.name, "");
    await StorageProvider.write(StorageKey.status, "");
    Get.offAllNamed(Routes.LOGIN);
  }
}
