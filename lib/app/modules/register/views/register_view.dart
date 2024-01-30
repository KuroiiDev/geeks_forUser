import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_clipper.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
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

  // Personal Widget

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
                  "Join Us!",
                  style:GoogleFonts.creteRound(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1
                  )
              ),
              SizedBox(height: 50),
              Form(
                  key: controller.formKey,
                  child:Column(
                    children: [
                      _buildEmailField(),
                      SizedBox(height: 20),
                      _buildNameField(),
                      SizedBox(height: 20),
                      _buildPasswordField(controller.passwordController, "Create a Password"),
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
              onPressed: ()=>Get.offAllNamed(Routes.LOGIN),
              child: Text(
                "Already a Geeks? Click Here to Login",
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
    bool isObscured = true;
    return TextFormField(
      controller: controller.passwordController,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          icon: isObscured ? Icon(Icons.visibility, color: Colors.white,) : Icon(Icons.visibility_off, color: Colors.white,),
          onPressed: () {
            isObscured = !isObscured;
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
      obscureText: true,
      validator: (value){
        if (value!.isEmpty){
          return "Please Fill out your password!";
        }
        return null;
      },
    );
  }
  Widget _BuildButtonRegister(){
    return ElevatedButton.icon(
      onPressed: (){controller.register();},
      label: Text("Register", style: GoogleFonts.alata(color: Colors.white, fontSize: 25)),
      icon: Icon(Icons.app_registration, color: Colors.white),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(25.0),
        primary: Color(0xacffd1ff),
        elevation: 5,
        shape: StadiumBorder(),
      ),
    );
  }
}
