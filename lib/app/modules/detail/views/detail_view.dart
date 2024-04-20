import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geek/app/data/constant/global_color.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/base_64_converter.dart';
import '../../../widgets/custom_clipper.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: FloatingActionButton.small(
            onPressed: () => Get.back(),
            backgroundColor: Colors.black38,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.close, color: Colors.white),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(child: _bookDetails(context)),
    ));
  }

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) => SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 130),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                          color: GlobalColor.darkTitle,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Renting Confirmation',
                            style: GoogleFonts.alata(
                                color: GlobalColor.subtitle,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                color: GlobalColor.title.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 2, color: GlobalColor.soft)),
                            child: TextField(
                              style: GoogleFonts.alata(
                                  color: GlobalColor.darkTitle, fontSize: 20),
                              controller: controller.dateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: "Click to assign Return Date",
                                hintStyle: GoogleFonts.alata(
                                    color:
                                        GlobalColor.darkTitle.withOpacity(0.4),
                                    fontSize: 20),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: GlobalColor.soft,
                                ),
                                filled: false,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onTap: () => _showDatePicker(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 45),
                          child: ElevatedButton(
                            onPressed: (){
                              if (controller.dateController.text.isEmpty){
                                Get.snackbar('Error', 'Pick Your Date', backgroundColor: Colors.red);
                              } else {
                                controller.requestRent();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalColor.soft,
                              elevation: 8,
                              shape: const CircleBorder(),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Icon(Icons.shopping_cart_checkout, size: 90),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ));
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    ).then((value) {
      controller.returnDate = value.toString();
      log(controller.returnDate);
      controller.dateController.text =
          "${value?.day.toString()}-${value?.month.toString()}-${value?.year.toString()}";
      FocusScope.of(context).unfocus();
    });
  }

  bool _check(String text) {
    if (text == "AVAILABLE") {
      return true;
    } else {
      return false;
    }
  }

  Widget _bookDetails(BuildContext context) {
    return Obx(() {
      var bookDetail = controller.bookDetail.value;
      var state = controller.genreData.value;
      var ratingDat = controller.ratingData.value;
      if (bookDetail == null) {
        return _template(context);
      } else {
        return Column(
          children: [
            SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                width: double.infinity,
                child: ClipPath(
                  clipper: CustomClipperWidget(),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: ImageConverter.base64ToImage(bookDetail.cover ?? '-'),
                            fit: BoxFit.cover,
                            opacity: 450)),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: ImageConverter.base64ToImage(bookDetail.cover ?? '-'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                )),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  bookDetail.title ?? '-',
                  style: GoogleFonts.alata(
                      color: GlobalColor.title,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  bookDetail.writer ?? '-',
                  style: GoogleFonts.alata(
                      color: GlobalColor.subtitle, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RatingBarIndicator(
                  rating: (bookDetail.rating ?? 0).toDouble(),
                  itemCount: 5,
                  itemSize: 35,
                  unratedColor: Colors.black12,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: GlobalColor.softDeep,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.shopping_cart,
                        size: 30, color: GlobalColor.title),
                    Text((bookDetail.rented).toString(),
                        style: GoogleFonts.dangrek(
                            color: GlobalColor.soft, fontSize: 23))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              width: Get.width,
              decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(width: 1, color: GlobalColor.soft)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (bookDetail.publishYear ?? '-').toString(),
                    style: GoogleFonts.alata(
                        color: GlobalColor.subtitle,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (bookDetail.publisher ?? '-').toString(),
                    style: GoogleFonts.alata(
                        color: GlobalColor.subtitle,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(width: 1, color: GlobalColor.soft)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Synopsis',
                        style: GoogleFonts.alata(
                            color: GlobalColor.subtitle,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      //color: Color(0xff9585ff),
                      child: Text(
                        (bookDetail.synopsis).toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                        style: GoogleFonts.alata(
                            color: GlobalColor.text, fontSize: 18),
                      ),
                    ),
                  ]),
            ),

            // Genre Build
            state != null ? Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(width: 1, color: GlobalColor.soft)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Genre',
                        style: GoogleFonts.alata(
                            color: GlobalColor.subtitle,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      //color: Color(0xff9585ff),
                      child: SizedBox(
                        width: Get.width,
                        height: 43,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                child: InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.GENRE, parameters: {
                                      'id' : state[index].genreId.toString(),
                                      'genre' : state[index].genre!.genre.toString()
                                    });
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7.0)),
                                    child: Container(
                                        height: 30,
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          state[index].genre!.genre.toString(),
                                          style: GoogleFonts.alata(
                                              color: GlobalColor.soft, fontSize: 20),
                                          textAlign: TextAlign.left,
                                        )
                                    ),
                                  ),
                                ),
                              );
                            }
                        )
                      ),
                    ),
                  ]),
            ) : SizedBox(),

            // Rating Build
            ratingDat != null ? Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(width: 1, color: GlobalColor.soft)),
              ),
              child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      //color: Color(0xff9585ff),
                      child: SizedBox(
                          width: Get.width,
                          height: 200,
                          child: ListView.builder(
                              //scrollDirection: Axis.horizontal,
                              itemCount: ratingDat.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7.0)),
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: Colors.black, width: 2),
                                                  image: DecorationImage(
                                                    image: ImageConverter.base64ToImage(ratingDat[index].user?.profile?? '-'),
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ratingDat[index].user!.name.toString(),
                                                  style: GoogleFonts.alata(
                                                      color: GlobalColor.subtitle, fontSize: 20),
                                                  textAlign: TextAlign.left,
                                                ),
                                                RatingBarIndicator(
                                                  rating: (ratingDat[index].rating ?? 1),
                                                  itemCount: 5,
                                                  itemSize: 35,
                                                  unratedColor: Colors.black12,
                                                  itemBuilder: (context, index) => Icon(
                                                    Icons.star,
                                                    color: GlobalColor.softDeep,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                );
                              }
                          )
                      ),
                    )
            ) : SizedBox(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_check(bookDetail.status.toString())) {
                        _showDialog(context);
                      } else {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Book Unavailable!',
                            text: 'This Book is currently Rented by someone else',
                            confirmBtnText: 'Okay'
                        );
                      }
                    },
                    icon: Icon(
                      _check(bookDetail.status.toString())
                          ? Icons.shopping_cart
                          : Icons.close,
                      color: GlobalColor.title,
                      size: 25,
                    ),
                    label: Text(
                      _check(bookDetail.status.toString())
                          ? 'Rent This Book'
                          : 'Book Unavailable',
                      style: GoogleFonts.alata(
                          color: GlobalColor.subtitle,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
                      backgroundColor: GlobalColor.soft,
                      elevation: 5,
                      shape: const StadiumBorder(),
                    ),
                  ),
                  controller.isSaved.value ?
                  ElevatedButton(
                    onPressed: () => controller.removeBookmark(),
                    style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      backgroundColor: Colors.red,
                      elevation: 5,
                      shape: const StadiumBorder(),
                    ),
                    child: const Icon(
                      Icons.bookmark_remove,
                      color: Colors.white,
                      size: 25,
                    ),
                  )
                  :
                  ElevatedButton(
                    onPressed: () =>controller.addBookmark(),
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      backgroundColor: GlobalColor.soft,
                      elevation: 5,
                      shape: const StadiumBorder(),
                    ),
                    child: Icon(
                      Icons.bookmark_add,
                      color: GlobalColor.title,
                      size: 25,
                    ),
                  )
                  ,
                ],
              ),
            )
          ],
        );
      }
    });
  }

  Widget _template(context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: double.infinity,
            child: ClipPath(
              clipper: CustomClipperWidget(),
              child: Shimmer.fromColors(
                baseColor: const Color(0xffb6b6b6),
                highlightColor: const Color(0xffffffff),
                child: Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: GlobalColor.soft,
                  ),
                ),
              ),
            )),
        Shimmer.fromColors(
          baseColor: const Color(0xffb6b6b6),
          highlightColor: const Color(0xffffffff),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 45,
                width: Get.width * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: Get.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 35),
        Shimmer.fromColors(
          baseColor: const Color(0xffb6b6b6),
          highlightColor: const Color(0xffffffff),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RatingBarIndicator(
                rating: 1,
                itemCount: 5,
                itemSize: 35,
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
        const SizedBox(height: 50),
        Shimmer.fromColors(
          baseColor: const Color(0xffb6b6b6),
          highlightColor: const Color(0xffffffff),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            width: Get.width,
            decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(width: 1, color: GlobalColor.soft)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25,
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 25,
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(width: 1, color: GlobalColor.soft)),
          ),
          child:
          Shimmer.fromColors(
            baseColor: const Color(0xffb6b6b6),
            highlightColor: const Color(0xffffffff),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                    height: 25,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black,
                    ),
                  ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //color: Color(0xff9585ff),
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
                  ),
            ),
          ]),
              ),
        )
      ],
    );
  }
}
