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
              height: MediaQuery.sizeOf(context).height,
              width: double.infinity,
              child: _buildInputFields(),
            ),
            _buildSocialLogins()
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
                      _buildTextFormField(controller.emailController, Icons.person, "Email", "Email Can't Be Empty!"),
                      SizedBox(height: 20),
                      _buildTextFormField(controller.passwordController, Icons.lock, "Password", "Password Can't Be Empty!", isPassword: true),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: (){},
                        child: Text("Login", style: GoogleFonts.alata(color: Colors.white, fontSize: 25)),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                          onPressed: (){},
                          child:
                          Text(
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
  Widget _buildSocialLogins(){
    return Container();
  }
  Widget _buildTextFormField(TextEditingController controller, IconData icon, String hint, String ifEmpty,{bool isPassword = false}){
    return TextFormField(
      controller: controller,
      style: GoogleFonts.alata(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.alata(color: Colors.white.withOpacity(0.4), fontSize: 20),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: isPassword,
      validator: (value){
        if (value!.isEmpty){
          return ifEmpty;
        }
        return null;
      },
    );
  }
}