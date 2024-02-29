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
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffe18bff), Color(0xff7000FF)]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.002),
              Image(
                image: AssetImage("assets/images/logo_white.png"),
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
              SizedBox(height: 60),
              Form(
                key: controller.formKey,
                  child:Column(
                    children: [
                      _buildEmailField(),
                      SizedBox(height: 20),
                      Obx(() =>
                      _buildPasswordField()
                      ),
                      SizedBox(height: 30),
                      _BuildButtonLogin(),
                      SizedBox(height: 15),
                      TextButton(
                          onPressed: (){},
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: ()=>Get.offAllNamed(Routes.REGISTER),
              child: Text(
                "Not a Geeks? Click Here to Join",
                style: GoogleFonts.alata(color: Colors.deepPurple, fontSize: 23),
              )
          )
        ],
      ),
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
  Widget _buildPasswordField(){
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
        hintText: "Password",
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
      validator: (value){
        if (value!.isEmpty){
          return "Please Fill out your password!";
        }
        return null;
      },
    );
  }
  Widget _BuildButtonLogin(){
    return ElevatedButton.icon(
      onPressed: (){controller.login();},
      label: Text("Login", style: GoogleFonts.alata(color: Colors.white, fontSize: 25)),
      icon: Icon(Icons.login, color: Colors.white),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20.0),
        primary: Color(0xacffd1ff),
        elevation: 5,
        shape: StadiumBorder(),
      ),
    );
  }
}