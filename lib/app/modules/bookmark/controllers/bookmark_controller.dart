import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geek/app/data/model/response_bookmark_get.dart';
import 'package:geek/app/data/provider/storage_provider.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class BookmarkController extends GetxController with StateMixin {

  var bookmarkDetail = Rxn<List<DataBookmark>>();

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
    bookmarkDetail.value = null;
    var id = StorageProvider.read(StorageKey.idUser);
    try {
      final response = await ApiProvider.instance().get("${Endpoint.bookmark}/$id");
      if (response.statusCode == 200) {
        final ResponseBookmark responseBookmark = ResponseBookmark.fromJson(response.data);
        if (responseBookmark.data!.isEmpty){
        }else {
          bookmarkDetail(responseBookmark.data);
        }
      }else {
        change(null, status: RxStatus.error("Internal Server Error"));
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

  void removeBookmark(var id) async{
    try {
      final response = await ApiProvider.instance().get("${Endpoint.removeBookmark}/$id");
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
