import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_get.dart';
import '../../../data/provider/api_provider.dart';

class IndexController extends GetxController with StateMixin<List<DataBook>> {
  //TODO: Implement IndexController

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
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.book);
      if (response.statusCode == 200) {
        final ResponseBook responseBook = ResponseBook.fromJson(response.data);
        if (responseBook.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          change(responseBook.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Failed"));
      }
    }on DioException catch(e) {
      if (e.response != null){
        if (e.response?.data != null){
          change(null, status: RxStatus.error("${e.response?.data['message']}']"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    }catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
