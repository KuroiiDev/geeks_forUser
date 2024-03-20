import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: GestureDetector(
                  onTap: (){
                    Get.toNamed(
                        Routes.DETAIL,
                        parameters: {
                          'id' : controller.id,
                          //'title' : controller.title.value,
                          //'writer' : controller.writer.value,
                          //'publisher' : controller.publisher,
                          //'synopsis' : controller.synopsis.value,
                          //'status' : controller.status,
                          //'rented' : controller.rented,
                          //'publish_year' : controller.publish_year,
                        }
                    );
                  },
                  child: _buildTopBook()
              )
            )
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
            Obx(() =>Text("Hello, ${controller.name}!",
              style: GoogleFonts.dangrek(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,)),
            Text("What to read today?",
              style: GoogleFonts.alata(color: Colors.white70, fontSize: 15),
              textAlign: TextAlign.left,)
          ],
        ),
        Icon(Icons.circle, size: 75,)
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

  Widget _buildTopBook(){
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      color: Colors.white,
      child: Container(
          height: 200.0,
          width: Get.width*0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    height: 160,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/book_loading.png")
                        )
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: Get.width *0.50,
                        child: Obx(()=>Text(
                            controller.title.value,
                            overflow: TextOverflow.ellipsis, maxLines: 1,
                            style:GoogleFonts.creteRound(
                                fontSize: 30,
                                color: Color(0xff7055f8),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1
                            )
                        )),
                      ),
                        Obx(()=>Text(controller.writer.value,
                        style: GoogleFonts.alata(color: Colors.black54, fontSize: 15),
                        textAlign: TextAlign.left,))
                    ],
                  ),
                  Container(
                    height: 100,
                    width: Get.width *0.57,
                    child: Obx(()=>Text(controller.synopsis.value,
                      overflow: TextOverflow.ellipsis, maxLines: 4,
                      style: GoogleFonts.alata(color: Colors.black54, fontSize: 15),
                      textAlign: TextAlign.left,)),
                  )
                ],
              )
            ],
          )
      ),
    );
  }
}
