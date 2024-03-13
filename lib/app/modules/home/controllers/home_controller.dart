import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_get.dart';
import '../../../data/provider/api_provider.dart';
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
    getData();
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
  getData() async{
    try{
      final response = await ApiProvider.instance().get("${Endpoint.book}/top");
      if (response.statusCode == 200) {
        final ResponseBook responseBook = ResponseBook.fromJson(response.data);
        if (responseBook.data!.isEmpty){
          log("Kosong bg");
        }
      }
    }catch(e){
      log("Error bang");
    }
  }
}
