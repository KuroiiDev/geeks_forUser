import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:geek/app/widgets/base_64_converter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class EditController extends GetxController {
  final GlobalKey<FlutterPwValidatorState> validatorKey = GlobalKey<FlutterPwValidatorState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isObs = true.obs;
  var isName = false.obs;
  var isPass = false.obs;

  var imagePath = ''.obs;
  var imageSize = ''.obs;

  String profilePict = 'NONE';

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
    log(isObs.value.toString());
  }

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath.value = image.path;
      imageSize.value =
      "${((File(imagePath.value)).lengthSync() / 512 / 512).toStringAsFixed(2)}Mb";
      Get.snackbar("Success", "Selected!", backgroundColor: Colors.green);
    } else {
      Get.snackbar("Sorry", "Canceled", backgroundColor: Colors.orange);
    }
  }

  data() async{

    if (imagePath.value.isNotEmpty ||
        imagePath.value.trim() != "" ||
        imagePath.value != "") {
      profilePict = (await ImageConverter.imageToBase64(imagePath.value))!;
    } else {
    }

    FocusScope.of(Get.context!).unfocus();
    if (profilePict != 'NONE'){
      log("Name: ${nameController.text}");
      log("Pass: ${passwordController.text}");
      try {
        final response;
        String url = "${Endpoint.edit}/${StorageProvider.read(StorageKey.idUser)}";
        FocusScope.of(Get.context!).unfocus();
        if (!isName.value && !isPass.value){

          response = await ApiProvider.instance().post(url,data:{"profile" : profilePict});

        }else if (!isPass.value){

          response = await ApiProvider.instance().post(url,data:{"name": nameController.text.toString(), "profile" : profilePict});

        } else if (!isName.value) {

          response = await ApiProvider.instance().post(url,data:{"password": passwordController.text.toString(), "profile" : profilePict});

        } else {

          response = await ApiProvider.instance().post(url,data:
          {
            "name": nameController.text.toString(),
            "password": passwordController.text.toString(),
            "profile" : profilePict
          });

        }
        if (response.statusCode == 201) {
          Get.snackbar("Success", "Profile Edited!", backgroundColor: Colors.green);
        } else {
          Get.snackbar("Sorry", "Edit Failed", backgroundColor: Colors.orange);
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
    }else{
      QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Forbidden!',
          text: "Image Is Required!",
          confirmBtnText: 'I Understand');
    }

  }
}