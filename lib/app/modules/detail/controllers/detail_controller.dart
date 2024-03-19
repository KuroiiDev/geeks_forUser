import 'dart:developer';

import 'package:geek/app/data/model/response_byid_get.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class DetailController extends GetxController {

  late RxString id = "".obs;
  late RxString title = "".obs;
  late RxString writer = "".obs;
  late RxString publisher = "".obs;
  late RxString synopsis = "".obs;
  late RxString rented = "".obs;
  late RxString status = "".obs;
  late RxString publish_year = "".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
    update();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    id = Get.parameters['id']
        .toString()
        .obs;
    title = Get.parameters['title']
        .toString()
        .obs;
    writer = Get.parameters['writer']
        .toString()
        .obs;
    publisher = Get.parameters['publisher']
        .toString()
        .obs;
    synopsis = Get.parameters['synopsis']
        .toString()
        .obs;
    rented = Get.parameters['rented']
        .toString()
        .obs;
    status = Get.parameters['status']
        .toString()
        .obs;
    publish_year = Get.parameters['publish_year']
        .toString()
        .obs;
  }
}
