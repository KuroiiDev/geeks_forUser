import 'package:dio/dio.dart';
import 'package:geek/app/data/constant/endpoint.dart';
import 'package:geek/app/data/model/response_rent_id_get.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_provider.dart';

class RentController extends GetxController with StateMixin{
  //TODO: Implement RentController

  var rentData = Rxn<DataRent>();

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
}
