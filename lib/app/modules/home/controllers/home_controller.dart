import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_id_get.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class HomeController extends GetxController with StateMixin{
  //TODO: Implement HomeController

  var topBookData = Rxn<DataBookId>();

  final TextEditingController searchController = TextEditingController();
  RxString name = StorageProvider.read(StorageKey.name).obs;

  String id = "0";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
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

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response =
      await ApiProvider.instance().get("${Endpoint.book}/top");
      if (response.statusCode == 200) {
        final ResponseBookId responseBook = ResponseBookId.fromJson(response.data);
        if (responseBook.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          topBookData(responseBook.data);
          change(null, status: RxStatus.success());
          id = (responseBook.data?.id).toString();
        }
      } else {
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          //change(null,status: RxStatus.error("${e.response?.data['message']}"));
          log(e.response?.data['message'] ?? "");
          Get.snackbar("Network", "No Internet Connection", backgroundColor: Colors.red);
        }
      } else {
        log(e.message ?? "");
        Get.snackbar("Network", "No Internet Connection", backgroundColor: Colors.red);
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
