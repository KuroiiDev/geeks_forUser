import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/data/model/response_login_post.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isObs = true.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    String status = StorageProvider.read(StorageKey.status);
    log("status : $status");
    if (status == "logged"){
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void obscurePass(){
    isObs.value = !isObs.value;
    update();
    print(isObs.value);
  }

  login() async {
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,data: dio.FormData.fromMap({
          "email": emailController.text.toString(),
          "password": passwordController.text.toString()}));
        if (response.statusCode == 200) {
          ResponseLoginPost responseLogin = ResponseLoginPost.fromJson(response.data);
          await StorageProvider.write(StorageKey.idUser, responseLogin.token.toString());
          await StorageProvider.write(StorageKey.status, "logged");
          Get.snackbar("Success", "Login Success!", backgroundColor: Colors.green);
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Sorry", "Login Failed!", backgroundColor: Colors.orange);
        }
      }
    }on dio.DioException catch(e) {
      if (e.response != null){
        if (e.response?.data != null){
          Get.snackbar("Sorry", "${e.response?.data['message']}", backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    }catch (e) {
    Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
  skip() async{
    FocusScope.of(Get.context!).unfocus();
    formKey.currentState?.save();
    if (formKey.currentState!.validate()) {
        String email = emailController.text.toString();
        String pass = passwordController.text.toString();
      if (email == "user@example.com" && pass == "user") {
        Get.snackbar("Success", "Login Success!", backgroundColor: Colors.green);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        Get.snackbar("Sorry", "Login Failed!", backgroundColor: Colors.orange);
      }
    }
  }
}
