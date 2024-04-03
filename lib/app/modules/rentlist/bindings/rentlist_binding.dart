import 'package:get/get.dart';

import '../controllers/rentlist_controller.dart';

class RentlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentlistController>(
      () => RentlistController(),
    );
  }
}
