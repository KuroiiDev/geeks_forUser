import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_byid_get.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class HomeController extends GetxController with StateMixin<DataBook>{
  //TODO: Implement HomeController

  final TextEditingController searchController = TextEditingController();
  RxString name = "".obs;

  String id = "0";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    name = StorageProvider.read(StorageKey.name).obs;
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
        final ResponseByid responseBook = ResponseByid.fromJson(response.data);
        if (responseBook.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseBook.data, status: RxStatus.success());
          id = (responseBook.data?.bookId).toString();
        }
      } else {
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null,
              status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
