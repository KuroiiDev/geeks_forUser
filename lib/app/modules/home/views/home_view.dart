import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/widgets/base_64.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff7055f8),
              Color(0xffe3dbff),
              Color(0xfff3f3f3)
            ])),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  child: _buildUserData()),
              Padding(
                padding: EdgeInsets.all(10),
                child: _buildSearchBox(),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: GestureDetector(
                      onTap: () {
                        if (controller.id != "0") {
                          Get.toNamed(Routes.DETAIL, parameters: {
                            'id': controller.id,
                          });
                        }
                      },
                      child: _buildTopBook())),
              Container(height: 500)
            ],
          ),
        ),
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
            Obx(() => Text(
                  "Hello, ${controller.name}!",
                  style: GoogleFonts.dangrek(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                )),
            Text(
              "What to read today?",
              style: GoogleFonts.alata(color: Colors.white70, fontSize: 15),
              textAlign: TextAlign.left,
            )
          ],
        ),
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Icon(Icons.search),
          Container(
            width: 300,
            child: TextFormField(
              controller: controller.searchController,
              onChanged: (query) {
                FocusScope.of(Get.context!).unfocus();
                controller.searchController.clear();
                Get.toNamed(Routes.INDEX, parameters: {
                  'query': query,
                });
              },
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

  Widget _buildTopBook() {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      color: Colors.white,
      child: Container(
          height: 250.0,
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Obx(() {
            if (controller.topBookData.value == null) {
              return _template();
            } else {
              var state = controller.topBookData.value;
              return Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                            height: 180,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    width: 2, color: GlobalColor.darkTitle),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: base64widget(state?.cover ?? '-'))),
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
                                width: Get.width * 0.50,
                                child: Text(state?.title ?? "-",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.creteRound(
                                        fontSize: 30,
                                        color: GlobalColor.title,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1)),
                              ),
                              Text(
                                state?.writer ?? '-',
                                style: GoogleFonts.alata(
                                    color: GlobalColor.soft, fontSize: 15),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 100,
                            width: Get.width * 0.50,
                            child: Text(
                              state?.synopsis ?? '-',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: GoogleFonts.alata(
                                  color: GlobalColor.text, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: 1,
                          itemCount: 5,
                          itemSize: 30,
                          unratedColor: GlobalColor.soft,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: GlobalColor.title,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.shopping_cart,
                                size: 30, color: GlobalColor.title),
                            Text((state?.rented).toString(),
                                style: GoogleFonts.dangrek(
                                    color: GlobalColor.soft, fontSize: 23))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          })),
    );
  }

  Widget _template() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Color(0xffb6b6b6),
          highlightColor: Color(0xffffffff),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    height: 180,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border:
                            Border.all(width: 2, color: GlobalColor.darkTitle),
                        color: Colors.black),
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
                      SizedBox(height: 10),
                      Container(
                        height: 30,
                        width: Get.width * 0.50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 20,
                        width: Get.width * 0.50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.only(top: 15),
                      height: 100,
                      width: Get.width * 0.50,
                      child: Column(
                        children: [
                          Container(
                            height: 15,
                            width: Get.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3),
                          Container(
                            height: 15,
                            width: Get.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3),
                          Container(
                            height: 15,
                            width: Get.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3),
                          Container(
                            height: 15,
                            width: Get.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Shimmer.fromColors(
            baseColor: Color(0xffb6b6b6),
            highlightColor: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBarIndicator(
                  rating: 1,
                  itemCount: 5,
                  itemSize: 30,
                  unratedColor: GlobalColor.soft,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: GlobalColor.title,
                  ),
                ),
                Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildFloatingButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: FloatingActionButton(
          onPressed: (){
            Get.toNamed(Routes.INDEX);
          },
          child: Icon(Icons.list_alt, color: Colors.white, size: 25,),
          backgroundColor: Color(0xff5947ff),
          shape: CircleBorder()
      ),
    );
  }
}
