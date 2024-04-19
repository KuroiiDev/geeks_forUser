import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geek/app/data/model/response_genre_genre_get.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class GenreController extends GetxController with StateMixin {
  var genreData = Rxn<List<DataGenre>>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
    genreData.value = null;
    var genreId = Get.parameters['id'];
    try {
      final response = await ApiProvider.instance().get("${Endpoint.genreGenre}/$genreId");
      if (response.statusCode == 200) {
        final ResponseGenreGenre responseBook = ResponseGenreGenre.fromJson(response.data);
        if (responseBook.data!.isEmpty){
          log("Empty Data!");
        }else{
          genreData(responseBook.data);
        }
      } else {
        log("Internal Server Error");
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
