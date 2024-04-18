import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_get.dart';
import '../../../data/provider/api_provider.dart';

class IndexController extends GetxController with StateMixin {

  final TextEditingController searchController = TextEditingController();
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  FocusNode searchBar = FocusNode();
  var bookData = Rxn<List<DataBook>>();

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

  Future<void> getData() async{
    try {
      final response = await ApiProvider.instance().get("${Endpoint.book}/az");
      if (response.statusCode == 200) {
        final ResponseBook responseBook = ResponseBook.fromJson(response.data);
        if (responseBook.data!.isEmpty){
          log("Empty Data!");
        }else{
          bookData(responseBook.data);
        }
      } else {
        log("Internal Server Error");
      }
    }on DioException catch(e) {
      if (e.response != null){
        if (e.response?.data != null){
          log("${e.response?.data['message']}']");
        }
      } else {
        log(e.message ?? "");
      }
    }catch (e) {
      log(e.toString());
    }
  }
}
