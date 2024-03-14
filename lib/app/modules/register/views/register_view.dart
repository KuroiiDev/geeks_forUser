import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_clipper.dart';
import '../controllers/register_controller.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.93,
                width: double.infinity,
                child: _buildInputFields(),
              ),
              _buildRegister()
            ],
          ),
        )
    );
  }

  // Personal Widget

  Widget _buildInputFields(){
    return ClipPath(
      clipper: CustomClipperWidget(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff4e00a2), Color(0xff7055f8)]
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.002),
              Image(
                image: AssetImage("assets/images/logo_white.png"),
                height: Get.height * 0.15,
              ),
              Text(
                  "Join Us!",
                  style:GoogleFonts.creteRound(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1
                  )
              ),
              SizedBox(height: 20),
              Form(
                  key: controller.formKey,
                  child:Column(
                    children: [
                      _buildEmailField(),
                      SizedBox(height: 20),
                      _buildNameField(),
                      SizedBox(height: 20),
                      Obx(() =>
                          _buildPasswordField()
                      ),
                      SizedBox(height: 5),
                      _buildPasswordValidator(),
                      SizedBox(height: 30),
                      _BuildButtonRegister(),
                      SizedBox(height: 15),
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: ()=>Get.to(Get.toNamed(Routes.LOGIN), transition: Transition.rightToLeftWithFade),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a Geeks? ",
                    style: GoogleFonts.alata(color: Color(0xff1d00bd), fontSize: 23),
                  ),
                  Text(
                    "Login Now",
                    style: GoogleFonts.alata(color: Color(0xff9585ff), fontSize: 23),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  // Micro Widget..

  Widget _buildPasswordValidator() {
    return FlutterPwValidator(
        width: 360,
        height: 100,
        minLength: 8,
        uppercaseCharCount: 1,
        numericCharCount: 1,
        specialCharCount: 1,
        onSuccess: () {},
        key: controller.validatorKey,
        controller: controller.passwordController,
        defaultColor: Colors.white70,
        failureColor: Colors.redAccent,
    );
  }

  Widget _buildEmailField(){
    return TextFormField(
      controller: controller.emailController,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: GoogleFonts.alata(color: Colors.white.withOpacity(0.4), fontSize: 20),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderSide: BorderSide.none),
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
  Widget _buildNameField(){
    return TextFormField(
      controller: controller.nameController,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        hintText: "Full Name",
        hintStyle: GoogleFonts.alata(color: Colors.white.withOpacity(0.4), fontSize: 20),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: false,
      validator: (value){
        if (value!.isEmpty){
          return "Please Fill out your Name!";
        }
        return null;
      },
    );
  }
  Widget _buildPasswordField(){
    var isObscured = true;
    return TextFormField(
      controller: controller.passwordController,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          icon: controller.isObs.value ? Icon(Icons.visibility, color: Colors.white,) : Icon(Icons.visibility_off, color: Colors.white,),
          onPressed: () {
            controller.obscurePass();
          },
        ),
        hintText: "Create a Password",
        hintStyle: GoogleFonts.alata(color: Colors.white.withOpacity(0.4), fontSize: 20),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: controller.isObs.value,
    );
  }
  Widget _BuildButtonRegister(){
    return ElevatedButton.icon(
      onPressed: (){controller.register();},
      label: Text("Register", style: GoogleFonts.alata(color: Colors.white, fontSize: 25)),
      icon: Icon(Icons.app_registration, color: Colors.white),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(17.0),
        primary: Color(0xace2d1ff),
        elevation: 5,
        shape: StadiumBorder(),
      ),
    );
  }
}
