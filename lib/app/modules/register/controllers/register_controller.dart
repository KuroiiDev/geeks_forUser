import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FlutterPwValidatorState> validatorKey = GlobalKey<FlutterPwValidatorState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
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
  register() async{
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.register,data:
        {
          "name": nameController.text.toString(),
          "email": emailController.text.toString(),
          "password": passwordController.text.toString(),
        });
        if (response.statusCode == 201) {
          Get.snackbar("Success", "Account Registered! Please Login", backgroundColor: Colors.green);
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Get.snackbar("Sorry", "Register Failed", backgroundColor: Colors.orange);
        }
      }
    }on DioException catch(e) {
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
}
