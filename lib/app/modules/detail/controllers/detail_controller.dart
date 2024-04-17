import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/data/model/response_book_id_get.dart';
import 'package:geek/app/data/model/response_bookmark_post.dart';
import 'package:geek/app/data/model/response_request_post.dart';
import 'package:geek/app/data/provider/storage_provider.dart';
import 'package:geek/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class DetailController extends GetxController with StateMixin {
  final count = 0.obs;
  final TextEditingController dateController = TextEditingController();
  String returnDate = "-";
  var bookDetail = Rxn<DataBookId>();
  var userId = StorageProvider.read(StorageKey.idUser);
  var bookmarkId = 0;
  RxBool isSaved = false.obs;

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

  Future<void> getData() async {
    checkBookmark();
    var bookId = Get.parameters['id'];
    try {
      final response =
          await ApiProvider.instance().get("${Endpoint.book}/id/$bookId");
      if (response.statusCode == 200) {
        final ResponseBookId responseBook =
            ResponseBookId.fromJson(response.data);
        if (responseBook.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          bookDetail(responseBook.data);
          change(null, status: RxStatus.success());
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

  requestRent() async {
    try {
      final response = await ApiProvider.instance().post(Endpoint.request,
          data: dio.FormData.fromMap({
            "user_id": userId,
            'book_id': Get.parameters['id'],
            'return_date': returnDate
          }));
      if (response.statusCode == 203) {
        QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            title: 'Forbidden!',
            text: "You Can't Rent more than one book at a time!",
            confirmBtnText: 'I Understand');
      } else if (response.statusCode == 201) {
        ResponseRequest responseRequest =
            ResponseRequest.fromJson(response.data);
        Get.snackbar("Success", "Rent Success!", backgroundColor: Colors.green);
        getData();
        Get.toNamed(Routes.RENT, parameters: {
          'rent_id': (responseRequest.data!.rent?.id).toString(),
        });
      } else {
        Get.snackbar("Sorry", "Rent Failed!", backgroundColor: Colors.orange);
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  addBookmark() async {
    try {
      final response = await ApiProvider.instance().post(Endpoint.addBookmark,
          data: dio.FormData.fromMap({
            "user_id": int.parse(userId),
            'book_id': int.parse(Get.parameters['id'] ?? '1')
          }));
      if (response.statusCode == 201) {
        Get.snackbar("Success", "Added to bookmark", backgroundColor: Colors.green);
        getData();
      } else if (response.statusCode == 203) {
        Get.snackbar("Sorry", "Already In bookmark!", backgroundColor: Colors.orange);
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  checkBookmark() async {
    try {
      final response = await ApiProvider.instance().post(Endpoint.checkBookmark,
          data: dio.FormData.fromMap({
            "user_id": int.parse(userId) ,
            'book_id': int.parse(Get.parameters['id'] ?? '1')
          }));
      if (response.statusCode == 200) {
        ResponseBookmark responseBookmark = ResponseBookmark.fromJson(response.data);
        bookmarkId = responseBookmark.id!;
        isSaved = true.obs;
      } else{
        isSaved = false.obs;
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  void removeBookmark() async{
    try {
      final response = await ApiProvider.instance().get("${Endpoint.removeBookmark}/$bookmarkId");
      if (response.statusCode == 200){
        QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            title: 'Success!',
            text: "Successfully Removed this bookmark!",
            confirmBtnText: 'Okay');
        getData();
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
