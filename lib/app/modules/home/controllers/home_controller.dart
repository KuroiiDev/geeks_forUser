import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/data/model/response_genre_get.dart';
import 'package:geek/app/data/model/response_user_get.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_get.dart';
import '../../../data/model/response_book_id_get.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class HomeController extends GetxController with StateMixin{
  //TODO: Implement HomeController

  var topBookData = Rxn<DataBookId>();
  var bookData = Rxn<List<DataBook>>();
  var bookRateData = Rxn<List<DataBook>>();
  var genreData = Rxn<List<DataGenre>>();
  var userData = Rxn<DataUser>();

  final TextEditingController searchController = TextEditingController();

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
    topBookData.value = null;
    bookData.value = null;
    bookRateData.value = null;
    genreData.value = null;
    userData.value = null;

    try {
      final response = await ApiProvider.instance().get("${Endpoint.user}/${StorageProvider.read(StorageKey.idUser)}");
      if (response.statusCode == 200) {
        final ResponseUser responseUser = ResponseUser.fromJson(response.data);
        userData(responseUser.data);
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
    // Get Genre List
    try {
      final response = await ApiProvider.instance().get("${Endpoint.genreList}/");
      if (response.statusCode == 200) {
        final ResponseGenre responseGenre = ResponseGenre.fromJson(response.data);
        if (responseGenre.data!.isEmpty){
          log("Empty Data!");
        }else{
          genreData(responseGenre.data);
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

    // Get Top Book
    try {
      final response =
      await ApiProvider.instance().get("${Endpoint.book}/top");
      if (response.statusCode == 200) {
        final ResponseBookId responseBook = ResponseBookId.fromJson(response.data);
        if (responseBook.data != null) {
          topBookData(responseBook.data);
          change(null, status: RxStatus.success());
          id = (responseBook.data?.id).toString();
        }
      } else {
        log("Gagal mengambil data");
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
      log(e.toString());
    }

    // Get Book
    try {
      final response = await ApiProvider.instance().get("${Endpoint.book}/");
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

    // Get Book By Rating
    try {
      final response = await ApiProvider.instance().get("${Endpoint.book}/rating");
      if (response.statusCode == 200) {
        final ResponseBook responseBook = ResponseBook.fromJson(response.data);
        if (responseBook.data!.isEmpty){
          log("Empty Data!");
        }else{
          bookRateData(responseBook.data);
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
