import 'dart:developer';

import 'package:geek/app/data/model/response_byid_get.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class DetailController extends GetxController {

  late RxString id = "".obs;
  late RxString title = "".obs;
  late RxString writer = "".obs;
  late RxString publisher = "".obs;
  late RxString synopsis = "".obs;
  late RxString rented = "".obs;
  late RxString status = "".obs;
  late RxString publish_year = "".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
    update();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async{
    try{
      final response = await ApiProvider.instance().get("${Endpoint.book}/id/${Get.parameters['id'].toString()}");
      if (response.statusCode == 200) {
        final ResponseById responseBook = ResponseById.fromJson(response.data);
        if (responseBook.data.isNull){
          log("Kosong bg");
        }else {
          id = Get.parameters['id'].toString().obs;
          title = responseBook.data!.title.toString().obs;
          writer = responseBook.data!.writer.toString().obs;
          publisher = responseBook.data!.publisher.toString().obs;
          synopsis = responseBook.data!.synopsis.toString().obs;
          rented = responseBook.data!.rented.toString().obs;
          status = responseBook.data!.status.toString().obs;
          publish_year = responseBook.data!.publishYear.toString().obs;
          log("Title: "+title.value);
          update();
        }
      }
    }catch(e){
      log("Error lagi: "+e.toString());
    }
  }

}
