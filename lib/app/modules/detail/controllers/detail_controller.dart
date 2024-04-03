
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geek/app/data/model/response_byid_get.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class DetailController extends GetxController with StateMixin {
  final count = 0.obs;
  final TextEditingController dateController = TextEditingController();
  String returnDate = "-";
  var bookDetail = Rxn<DataBook>();

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
        final ResponseByid responseBook = ResponseByid.fromJson(response.data);
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
}
