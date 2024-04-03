import 'package:dio/dio.dart';
import 'package:geek/app/data/model/response_user_get.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class AccountController extends GetxController with StateMixin<DataUser> {
  //TODO: Implement AccountController

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
    change(null, status: RxStatus.loading());
    var userId = StorageProvider.read(StorageKey.idUser);
    try {
      final response =
      await ApiProvider.instance().get("${Endpoint.user}/$userId");
      if (response.statusCode == 200) {
        final ResponseUser responseUser = ResponseUser.fromJson(response.data);
        if (responseUser.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseUser.data, status: RxStatus.success());
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
