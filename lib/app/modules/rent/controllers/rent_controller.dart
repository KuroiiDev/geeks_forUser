import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/endpoint.dart';
import 'package:geek/app/data/model/response_rent_id_get.dart';
import 'package:geek/app/data/provider/storage_provider.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/provider/api_provider.dart';

class RentController extends GetxController with StateMixin{
  //TODO: Implement RentController

  var rentData = Rxn<DataRent>();

  double ratingVal = 0;

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

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    var rentId = Get.parameters['rent_id'];
    try {
      final response = await ApiProvider.instance().get("${Endpoint.rentId}/$rentId");
      if (response.statusCode == 200) {
        final ResponseRentId responseRent = ResponseRentId.fromJson(response.data);
        if (responseRent.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          rentData(responseRent.data);
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

  rating(var bookId) async {
    var userId = StorageProvider.read(StorageKey.idUser);
    if (ratingVal <= 0) {
      QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Forbidden!',
          text: "Rating Value Can't be 0!",
          confirmBtnText: 'I Understand');
    } else {
      try {
        final response = await ApiProvider.instance().post(Endpoint.rating,
            data: dio.FormData.fromMap({
              "user_id": int.parse(userId),
              'book_id': int.parse(bookId),
              'rating': ratingVal
            }));
        if (response.statusCode == 201) {
          Get.snackbar("Success", "Rating Success!", backgroundColor: Colors.green);
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
  }
}
