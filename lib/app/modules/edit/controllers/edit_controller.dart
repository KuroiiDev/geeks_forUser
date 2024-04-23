import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
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
      "${((File(imagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}Mb";
      Get.snackbar("Success", "Selected!", backgroundColor: Colors.green);
    } else {
      imagePath.value = '';
      imageSize.value = '';
      Get.snackbar("Sorry", "Canceled", backgroundColor: Colors.orange);
    }
  }


  data() async {
    String url = "${Endpoint.edit}/${StorageProvider.read(StorageKey.idUser)}";
    FocusScope.of(Get.context!).unfocus();
    try {
      if (imagePath.value.isNotEmpty ||
          imagePath.value.trim() != "" ||
          imagePath.value != "") {
        var profilePic = ImageConverter.imageToBase64(imagePath.value);
        final response = await ApiProvider.instance().post(url, data: {

          "profile": profilePic
          /*
          "profile": await dio.MultipartFile.fromFile(
              imagePath.value,
              filename: imagePath.value.split('/').last,
              //contentType: MediaType('image', 'png')
          )
          */

        });
        if (response.statusCode == 201) {
          Get.snackbar("Success", "Profile Edited!",
              backgroundColor: Colors.green);
        } else {
          Get.snackbar("Sorry", "Edit Failed", backgroundColor: Colors.orange);
        }
      }

      if (isName.value) {
        final response = await ApiProvider.instance().post(url, data: {
          "name": nameController.text.toString(),
        });
        if (response.statusCode == 201) {
          Get.snackbar("Success", "Name Edited!",
              backgroundColor: Colors.green);
        } else {
          Get.snackbar("Sorry", "Edit Failed", backgroundColor: Colors.orange);
        }
      }

      if (isPass.value) {
        final response = await ApiProvider.instance().post(url, data: {
          "password": passwordController.text.toString(),
        });
        if (response.statusCode == 201) {
          Get.snackbar("Success", "Password Edited!",
              backgroundColor: Colors.green);
        } else {
          Get.snackbar("Sorry", "Edit Failed", backgroundColor: Colors.orange);
        }
      }

    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry 1", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry 2", e.toString(), backgroundColor: Colors.red);
        log(e.toString());
      }
    } catch (e) {
      Get.snackbar("Error 3", e.toString(), backgroundColor: Colors.red);
    }
  }
}
