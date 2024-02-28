import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 1;

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

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
