import 'package:flutter/material.dart';
import 'package:geek/app/widgets/custom_clipper.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  "Welcome Back Geek!",
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
                      _buildEmailField(controller.emailController),
                      SizedBox(height: 20),
                      _buildPasswordField(controller.passwordController),
                      SizedBox(height: 30),
                      _BuildButtonLogin(),
                      SizedBox(height: 15),
                      TextButton(
                          onPressed: (){},
                          child: Text(
                              "Forgot your Password? click here to reset!",
                              style: GoogleFonts.alata(color: Colors.white70, fontSize: 17)
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
              onPressed: (){},
              child: Text(
                "Not a Geeks? Click Here to Register!",
                style: GoogleFonts.alata(color: Colors.deepPurple, fontSize: 23),
              )
          )
        ],
      ),
    );
  }

  // Micro Widget..

  Widget _buildEmailField(TextEditingController controller){
    return TextFormField(
      controller: controller,
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
        }
        return null;
      },
    );
  }
  Widget _buildPasswordField(TextEditingController controller){
    return TextFormField(
      controller: controller,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
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
      obscureText: true,
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
      onPressed: (){},
      label: Text("Login", style: GoogleFonts.alata(color: Colors.white, fontSize: 25)),
      icon: Icon(Icons.login, color: Colors.white),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(25.0),
        primary: Color(0xacffd1ff),
        elevation: 5,
        shape: StadiumBorder(),
      ),
    );
  }
}