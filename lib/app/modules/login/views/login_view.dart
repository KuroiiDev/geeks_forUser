import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geek/app/widgets/custom_clipper.dart';
import 'package:email_validator/email_validator.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.9,
              width: double.infinity,
              child: _buildInputFields(),
            ),
            _buildRegister()
          ],
        ),
      )
    );
  }

  //Personal Widget..

  Widget _buildInputFields(){
    return ClipPath(
      clipper: CustomClipperWidget(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff7055f8), Color(0xff4e00a2)]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.002),
              Image(
                image: const AssetImage("assets/images/logo_white.png"),
                height: Get.height * 0.2,
              ),
              Text(
                  "Welcome Back!",
                  style:GoogleFonts.creteRound(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1
                  )
              ),
              const SizedBox(height: 60),
              Form(
                key: controller.formKey,
                  child:Column(
                    children: [
                      _buildEmailField(),
                      const SizedBox(height: 20),
                      Obx(() =>
                      _buildPasswordField()
                      ),
                      const SizedBox(height: 30),
                      _buildButtonLogin(),
                      const SizedBox(height: 15),
                      TextButton(
                          onPressed: (){
                            Color color = Colors.deepOrangeAccent;
                            switch (Random().nextInt(5)){
                              case 0:
                                color = Colors.cyanAccent;
                                break;
                              case 1:
                                color = Colors.white54;
                                break;
                              case 2:
                                color = Colors.greenAccent;
                                break;
                              case 3:
                                color = Colors.purpleAccent;
                                break;
                              case 4:
                                color = Colors.limeAccent;
                                break;
                            }
                            Get.snackbar("Lupa Yak?", "aawkaokwoakwoka Kasian", backgroundColor: color);
                          },
                          child: Text(
                              "Forgot your Password? click here to reset!",
                              style: GoogleFonts.alata(color: Colors.white70, fontSize: 14)
                          )
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRegister(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: ()=>Get.to(Get.toNamed(Routes.REGISTER), transition: Transition.leftToRightWithFade),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a Geeks? ",
                  style: GoogleFonts.alata(color: const Color(0xff1d00bd), fontSize: 23),
                ),
                Text(
                  "Join Us",
                  style: GoogleFonts.alata(color: const Color(0xff9585ff), fontSize: 23),
                ),
              ],
            )
        )
      ],
    );
  }

  // Micro Widget..

  Widget _buildEmailField(){
    return TextFormField(
      controller: controller.emailController,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: GoogleFonts.alata(color: Colors.white.withOpacity(0.4), fontSize: 20),
        prefixIcon: const Icon(
          Icons.email,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: false,
      validator: (value){
        if (value!.isEmpty){
          return "Please Fill out your email!";
        }else if (!EmailValidator.validate(value.toString())){
          return "Invalid Email Address";
        }
        return null;
      },
    );
  }
  Widget _buildPasswordField(){
    return TextFormField(
      controller: controller.passwordController,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          icon: controller.isObs.value ? const Icon(Icons.visibility, color: Colors.white,) : const Icon(Icons.visibility_off, color: Colors.white,),
          onPressed: () {
            controller.obscurePass();
          },
        ),
        hintText: "Password",
        hintStyle: GoogleFonts.alata(color: Colors.white.withOpacity(0.4), fontSize: 20),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: controller.isObs.value,
      validator: (value){
        if (value!.isEmpty){
          return "Please Fill out your password!";
        }
        return null;
      },
    );
  }
  Widget _buildButtonLogin(){
    return ElevatedButton.icon(
      onPressed: ()=>controller.login(),
      label: Text("Login", style: GoogleFonts.alata(color: Colors.white, fontSize: 25)),
      icon: const Icon(Icons.login, color: Colors.white),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20.0),
        backgroundColor: const Color(0xace2d1ff),
        elevation: 5,
        shape: const StadiumBorder(),
      ),
    );
  }
}