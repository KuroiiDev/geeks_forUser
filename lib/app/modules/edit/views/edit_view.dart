import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:geek/app/data/constant/global_color.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  const EditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: double.infinity,
                child: _buildInputFields(),
              ),
            ],
          ),
        )
    );
  }

  // Personal Widget

  Widget _buildInputFields(){
    return Container(
        decoration: const BoxDecoration(
            color: Color(0xfff3f3f3)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Edit Your Profile",
                  style:GoogleFonts.creteRound(
                      fontSize: 30,
                      color: GlobalColor.softDeep,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1
                  )
              ),
              const SizedBox(height: 40),
              Container(
                height: Get.height * 0.225,
                width: Get.width * 0.5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: GlobalColor.softDeep
                    )
                ),
                child: Obx(
                      () => InkWell(
                    onTap: () {
                      controller.getImage();
                    },
                    child: ClipOval(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: controller.imagePath.value == ''
                              ? Image.asset(
                            "assets/images/qr_logo.png",
                          )
                              : Image.file(
                            File(controller.imagePath.value),
                          ),
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Obx(() =>
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                              value: controller.isName.value,
                              shape: const CircleBorder(),
                              onChanged: (value){
                                if (value == true){
                                  controller.isName.value = true;
                                }else {
                                  controller.isName.value = false;
                                }
                              }
                          ),
                          SizedBox(width: Get.width *0.8, child: controller.isName.value ? _buildNameField() : const Text('Click To Enable Name'))
                        ],
                      ),


                      ),
                      const SizedBox(height: 20),
                      Obx(() =>
                          Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Checkbox(
                                      value: controller.isPass.value,
                                      shape: const CircleBorder(),
                                      onChanged: (value){
                                        if (value == true){
                                          controller.isPass.value = true;
                                        }else {
                                          controller.isPass.value = false;
                                        }
                                      }
                                  ),
                                  SizedBox(width: Get.width *0.8, child: controller.isPass.value ? _buildPasswordField() : const Text('Click To Enable Password'))
                                ],
                              ),
                              const SizedBox(height: 5),
                              controller.isPass.value ? SizedBox(width: Get.width *0.8, child: _buildPasswordValidator()) : const SizedBox(),
                            ],
                          )
                      ),
                      const SizedBox(height: 30),
                      _buildButtonRegister(),
                      const SizedBox(height: 15),
                ],
              )
            ],
          ),
        ),
    );
  }

  // Micro Widget..

  Widget _buildPasswordValidator() {
    return FlutterPwValidator(
      width: 360,
      height: 120,
      minLength: 8,
      uppercaseCharCount: 1,
      numericCharCount: 1,
      specialCharCount: 1,
      onSuccess: () {},
      key: controller.validatorKey,
      controller: controller.passwordController,
      defaultColor: GlobalColor.soft,
      failureColor: Colors.redAccent,
    );
  }

  Widget _buildNameField(){
    return TextField(
      controller: controller.nameController,
      enabled: controller.isName.value,
      style: GoogleFonts.alata(color: GlobalColor.soft, fontSize: 20),
      decoration: InputDecoration(
        hintText: "Full Name",
        hintStyle: GoogleFonts.alata(color: Colors.black38, fontSize: 20),
        prefixIcon: Icon(
          Icons.person,
          color: GlobalColor.softDeep,
        ),
        filled: true,
        fillColor: Colors.black12,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: false,
    );
  }
  Widget _buildPasswordField(){
    return TextField(
      controller: controller.passwordController,
      style: GoogleFonts.alata(color: GlobalColor.soft, fontSize: 20),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          icon: controller.isObs.value ? Icon(Icons.visibility, color: GlobalColor.softDeep) : const Icon(Icons.visibility_off, color: Colors.grey),
          onPressed: () {
            controller.obscurePass();
          },
        ),
        hintText: "Update Password",
        hintStyle: GoogleFonts.alata(color: Colors.black38, fontSize: 20),
        prefixIcon: Icon(
          Icons.lock,
          color: GlobalColor.softDeep,
        ),
        filled: true,
        fillColor: Colors.black12,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: controller.isObs.value,
    );
  }
  Widget _buildButtonRegister(){
    return ElevatedButton.icon(
      onPressed: (){controller.data();},
      label: Text("Update Data", style: GoogleFonts.alata(color: Colors.white, fontSize: 25)),
      icon: const Icon(Icons.edit, color: Colors.white),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(25.0),
        backgroundColor: GlobalColor.softDeep,
        elevation: 5,
        shape: const StadiumBorder(),
      ),
    );
  }
}
