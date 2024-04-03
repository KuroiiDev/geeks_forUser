import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geek/app/data/model/response_rent_user_get.dart';
import 'package:geek/app/data/provider/storage_provider.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class RentlistController extends GetxController with StateMixin<List<DataRent>>{

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

  Future<void> getData() async{
    var id = StorageProvider.read(StorageKey.idUser);
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get("${Endpoint.rentUser}/$id");
      if (response.statusCode == 200) {
        final ResponseRentUser responseRent = ResponseRentUser.fromJson(response.data);
        if (responseRent.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          change(responseRent.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Internal Server Error"));
      }
    }on DioException catch(e) {
      if (e.response != null){
        if (e.response?.data != null){
          change(null, status: RxStatus.loading());
          log("${e.response?.data['message']}']");
        }
      } else {
        change(null, status: RxStatus.error("No Internet Connection"));
        log(e.message ?? "");
      }
    }catch (e) {
      change(null, status: RxStatus.loading());
      log(e.toString());
    }
  }
}
