import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geek/app/data/model/response_rent_id_get.dart';
import 'package:geek/app/data/model/response_user_get.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class AccountController extends GetxController with StateMixin {
  //TODO: Implement AccountController

  var accountData = Rxn<DataUser>();
  var rentData = Rxn<DataRent>();

  RxString email = "-".obs;

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

  logout() async{
    await StorageProvider.write(StorageKey.idUser, "");
    await StorageProvider.write(StorageKey.name, "");
    await StorageProvider.write(StorageKey.status, "");
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> getData() async {
    getRent();
    var userId = StorageProvider.read(StorageKey.idUser);
    try {
      final response =
      await ApiProvider.instance().get("${Endpoint.user}/$userId");
      if (response.statusCode == 200) {
        final ResponseUser responseUser = ResponseUser.fromJson(response.data);
        if (responseUser.data == null) {
          log('Data Empty');
        } else {
          accountData(responseUser.data);
          log('Data Success');
        }
      } else {
        log("Data Failed");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          log(e.response?.data['message']);
        }
      } else {
        log(e.message ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getRent() async {
    var userId = StorageProvider.read(StorageKey.idUser);
    try {
      final response =
      await ApiProvider.instance().get("${Endpoint.rentCurrent}/$userId");
      if (response.statusCode == 200) {
        final ResponseRentId responseRentId = ResponseRentId.fromJson(response.data);
        if (responseRentId.data == null) {
          log('Rent Data Empty');
        } else {
          rentData(responseRentId.data);
          log('Rent Data Success');
        }
      } else {
        log("Rent Data Failed");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          log('Rent: '+e.response?.data['message']);
        }
      } else {
        log('Rent: '+(e.message ?? ""));
      }
    } catch (e) {
      log('Rent: '+e.toString());
    }
  }
}
