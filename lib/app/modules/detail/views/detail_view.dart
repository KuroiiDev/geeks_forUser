import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/widgets/base_64.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_clipper.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
      floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: FloatingActionButton.small(
            onPressed: () => Get.back(),
            child: Icon(Icons.close, color: Colors.white),
            backgroundColor: Colors.black38,
            elevation: 0,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
        child: SingleChildScrollView(
          child: controller.obx((state) => Column(
                children: [
                  SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      width: double.infinity,
                      child: ClipPath(
                        clipper: CustomClipperWidget(),
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0),
                          decoration:
                              BoxDecoration(
                                color: Colors.black,
                                  image: DecorationImage(
                                      image: base64widget(state?.cover ?? '-'),
                                      fit: BoxFit.cover,
                                      opacity: 450)
                              ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: base64widget(state?.cover ?? '-'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      )),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          state?.title ?? '-',
                          style: GoogleFonts.alata(
                              color: GlobalColor.title,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state?.writer ?? '-',
                          style: GoogleFonts.alata(
                              color: GlobalColor.subtitle, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
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
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: GlobalColor.soft)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (state?.publishYear ?? '-').toString(),
                          style: GoogleFonts.alata(
                              color: GlobalColor.subtitle,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          (state?.publisher ?? '-').toString(),
                          style: GoogleFonts.alata(
                              color: GlobalColor.subtitle,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 1, color: GlobalColor.soft)),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              'Synopsis',
                              style: GoogleFonts.alata(
                                  color: GlobalColor.subtitle,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            //color: Color(0xff9585ff),
                            child: Text(
                              (state?.synopsis).toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 8,
                              style: GoogleFonts.alata(
                                  color: GlobalColor.text, fontSize: 18),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart, color: GlobalColor.title, size: 25,),
                          label: Text(
                            'Rent This Book',
                            style: GoogleFonts.alata(
                                color: GlobalColor.subtitle,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 25),
                            primary: GlobalColor.soft,
                            elevation: 5,
                            shape: StadiumBorder(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.bookmark_add, color: GlobalColor.title, size: 25,),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                            primary: GlobalColor.soft,
                            elevation: 5,
                            shape: StadiumBorder(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    )));
  }
}
