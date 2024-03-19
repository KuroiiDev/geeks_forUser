import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_top_get.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final TextEditingController searchController = TextEditingController();
  RxString name = "".obs;

  String id = "0";
  RxString title = "Book Title".obs;
  RxString writer = "Writer's Name".obs;
  RxString synopsis = "(The Description) Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dignissim velit quis diam scelerisque, a faucibus diam feugiat. Nunc semper tempor tortor id facilisis. Suspendisse vel risus at ex vestibulum porta. Fusce metus sapien, viverra in mauris non, lobortis facilisis nunc. Integer rhoncus diam laoreet libero sodales, vel rutrum libero.".obs;
  String publisher = "";
  String status = "";
  String rented = "";
  String publish_year = "";

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
        final ResponseTop responseBook = ResponseTop.fromJson(response.data);
        if (responseBook.data!.isNull){
          log("Kosong bg");
        }else {
          id = responseBook.data!.id.toString();
          log("Id: "+id);
          title = responseBook.data!.title.toString().obs;
          writer = responseBook.data!.writer.toString().obs;
          publisher = responseBook.data!.publisher.toString();
          synopsis = responseBook.data!.synopsis.toString().obs;
          status = responseBook.data!.status.toString();
          rented = responseBook.data!.rented.toString();
          publish_year = responseBook.data!.publishYear.toString();
        }
      }
    }catch(e){
      log("Error bang: "+e.toString());
    }
  }
}
