
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/data/model/response_book_id_get.dart';
import 'package:geek/app/data/model/response_request_post.dart';
import 'package:geek/app/data/provider/storage_provider.dart';
import 'package:geek/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class DetailController extends GetxController with StateMixin {
  final count = 0.obs;
  final TextEditingController dateController = TextEditingController();
  String returnDate = "-";
  var bookDetail = Rxn<DataBookId>();

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
    change(null, status: RxStatus.loading());
    var bookId = Get.parameters['id'];
    try {
      final response = await ApiProvider.instance().get("${Endpoint.book}/id/$bookId");
      if (response.statusCode == 200) {
        final ResponseBookId responseBook = ResponseBookId.fromJson(response.data);
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
        final response = await ApiProvider.instance().post(Endpoint.request,data: dio.FormData.fromMap({
          "user_id": StorageProvider.read(StorageKey.idUser),
          'book_id': Get.parameters['id'],
          'return_date': returnDate}));
        if (response.statusCode == 201) {
          ResponseRequest responseRequest = ResponseRequest.fromJson(response.data);
          Get.snackbar("Success", "Rent Success!", backgroundColor: Colors.green);
          Get.toNamed(Routes.RENT, parameters: {
            'rent_id': (responseRequest.data!.rent?.id).toString(),
          });
        } else {
          Get.snackbar("Sorry", "Rent Failed!", backgroundColor: Colors.orange);
        }
    }on dio.DioException catch(e) {
      if (e.response != null){
        if (e.response?.data != null){
          Get.snackbar("Sorry", "${e.response?.data['message']}", backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    }
    catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
