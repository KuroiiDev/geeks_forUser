import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geek/app/data/constant/global_color.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/base_64_converter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff7055f8),
              Color(0xffe3dbff),
              Color(0xfff3f3f3)
            ])),
        child: LiquidPullToRefresh(
          onRefresh: ()=> controller.getData(),
          backgroundColor: const Color(0xff7055f8),
          color: Colors.white,
          showChildOpacityTransition: false,
          child: ListView(
            children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: _buildUserData()),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildSearchBox(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: Get.width,
                    height: 43,
                    child: _buildGenre(),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          width: Get.width *0.9,
                          child: Text(
                            "Top Rented Book",
                            style: GoogleFonts.alata(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              if (controller.id != "0") {
                                Get.toNamed(Routes.DETAIL, parameters: {
                                  'id': controller.id,
                                });
                              }
                            },
                            child: _buildTopBook()),
                      ],
                    )
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 15, top: 10),
                      width: Get.width *0.9,
                      child: Text(
                        "Our Popular book",
                        style: GoogleFonts.alata(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                        height: 220,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _buildRatedBook(),
                    ),
                  ],
                ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10, top: 15),
                    width: Get.width *0.9,
                    child: Text(
                      "Our Newest book",
                      style: GoogleFonts.alata(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 220,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _buildNewBook(),
                  ),
                ],
              )
              ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserData() {
    return Obx((){
      var state = controller.userData.value;
      if (state == null){
        return _template4();
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${state.name}!",
                  style: GoogleFonts.dangrek(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
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
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                  image: DecorationImage(
                    image: ImageConverter.base64ToImage(state.profile ?? '-'),
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ],
        );
      }
    });
  }

  Widget _buildSearchBox() {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          const Icon(Icons.search),
          SizedBox(
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

  Widget _buildGenre() {
    return Obx((){
      var state = controller.genreData.value;
      if (state == null) {
        return _template3();
      } else {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Container(
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        state[index].genre.toString(),
                        style: GoogleFonts.alata(
                            color: GlobalColor.soft, fontSize: 20),
                        textAlign: TextAlign.left,
                      )
                  ),
                ),
              );
            }
        );
      }
    });
  }

  Widget _buildNewBook() {
    return Obx((){
      var state = controller.bookData.value;
      if (state == null) {
        return _template2();
      } else {
        return SizedBox(
          width: Get.width,
          height: 20,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.DETAIL, parameters: {
                      'id' : (state[index].id).toString(),
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                                height: 160,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: ImageConverter.base64ToImage(state[index].cover ?? '-'),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              state[index].title ?? '-',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.alata(
                                  color: GlobalColor.title,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      }
    });
  }

  Widget _buildRatedBook() {
    return Obx((){
      var state = controller.bookRateData.value;
      if (state == null) {
        return _template2();
      } else {
        return SizedBox(
          width: Get.width,
          height: 20,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.DETAIL, parameters: {
                      'id' : (state[index].id).toString(),
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            height: 160,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: ImageConverter.base64ToImage(state[index].cover ?? '-'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              state[index].title ?? '-',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.alata(
                                  color: GlobalColor.title,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      }
    });
  }

  Widget _buildTopBook() {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      color: Colors.white,
      child: Container(
          height: 250.0,
          width: Get.width * 0.9,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Obx(() {
            var state = controller.topBookData.value;
            if (state == null) {
              return _template();
            } else {
              return Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    image: ImageConverter.base64ToImage(state.cover ?? '-'))),
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
                                padding: const EdgeInsets.only(top: 10),
                                width: Get.width * 0.50,
                                child: Text(state.title ?? "-",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.creteRound(
                                        fontSize: 25,
                                        color: GlobalColor.title,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1)),
                              ),
                              Text(
                                state.writer ?? '-',
                                style: GoogleFonts.alata(
                                    color: GlobalColor.soft, fontSize: 15),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            width: Get.width * 0.50,
                            child: Text(
                              state.synopsis ?? '-',
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
                          rating: (state.rating ?? 0).toDouble(),
                          itemCount: 5,
                          itemSize: 30,
                          unratedColor: Colors.black12,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: GlobalColor.softDeep,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.shopping_cart,
                                size: 30, color: GlobalColor.softDeep),
                            Text((state.rented).toString(),
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
          baseColor: const Color(0xffb6b6b6),
          highlightColor: const Color(0xffffffff),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                      const SizedBox(height: 10),
                      Container(
                        height: 30,
                        width: Get.width * 0.50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.only(top: 15),
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
                          const SizedBox(height: 3),
                          Container(
                            height: 15,
                            width: Get.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            height: 15,
                            width: Get.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 3),
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
            baseColor: const Color(0xffb6b6b6),
            highlightColor: const Color(0xffffffff),
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
  Widget _template2() {
    return SizedBox(
      width: Get.width,
      height: 20,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                color: Colors.white,
                child: Shimmer.fromColors(
                  baseColor: const Color(0xffb6b6b6),
                  highlightColor: const Color(0xffffffff),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 15,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
          }),
    );
  }

  Widget _template3() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: const Color(0xffb6b6b6),
            highlightColor: const Color(0xffffffff),
              child: Card(
                color: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                child: const SizedBox(
                    height: 50,
                    width: 85,
                ),
              ),
          );
        }
    );
  }

  Widget _template4() {
    return Shimmer.fromColors(
      baseColor: const Color(0xffb6b6b6),
      highlightColor: const Color(0xffffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: Get.width *0.7,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 20,
                width: Get.width *0.5,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)
                ),
              ),
            ],
          ),
          Container(
            height: 75,
            width: 75,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FloatingActionButton(
          onPressed: (){
            Get.toNamed(Routes.INDEX);
          },
          backgroundColor: const Color(0xff5947ff),
          shape: const CircleBorder(),
          child: const Icon(Icons.list_alt, color: Colors.white, size: 25,)
      ),
    );
  }
}
