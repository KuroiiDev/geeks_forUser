import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff7055f8), Color(0xffe3dbff), Color(0xfff3f3f3)]
          )
      ),
      child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: _buildUserData()
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: _buildSearchBox()
            ),
          ],
        ),
    );
  }

  Widget _buildUserData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() =>Text("Hello ${controller.name}!",
              style: GoogleFonts.dangrek(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,)),
            Text("What to read today?",
              style: GoogleFonts.alata(color: Colors.white70, fontSize: 15),
              textAlign: TextAlign.left,)
          ],
        ),
        Icon(Icons.circle, size: 60,)
      ],
    );
  }

  Widget _buildSearchBox() {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(children: [
          Icon(Icons.search),
          Container(
            width: 300,
            child: TextFormField(
              controller: controller.searchController,
              style: GoogleFonts.alata(fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: GoogleFonts.alata(color: Colors.black26),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
