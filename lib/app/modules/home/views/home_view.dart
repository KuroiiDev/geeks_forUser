import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          Obx(() =>Text("Hello ${controller.name}!",
                        style: GoogleFonts.dangrek(color: Colors.deepPurple, fontSize: 28, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,)),
                      Text("What to read today?",
                        style: GoogleFonts.dangrek(color: Colors.deepPurpleAccent, fontSize: 15),
                        textAlign: TextAlign.left,)
                    ],
                  ),
                  Icon(Icons.circle, size: 60,)
                ],
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(children: [
                Icon(Icons.search),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: GoogleFonts.dangrek(
                        color: Colors.black26
                      ),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
    );
  }
}
