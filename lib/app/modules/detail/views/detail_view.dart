import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SingleChildScrollView(
                    child: controller.obx(

                            (state) => Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height*0.45,
                                  width: double.infinity,
                                  child: ClipPath(
                                    clipper: CustomClipperWidget(),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [Color(0xff694dff), Color(0xffbfb2ff)]
                                          )
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 95),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 5, color: Colors.black),
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: base64widget(state?.cover ?? '-'),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        state?.title ?? '-',
                                        style: GoogleFonts.alata(color: Color(0xff1d00bd), fontSize: 35, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        state?.writer ?? '-',
                                        style: GoogleFonts.alata(color: Color(0xff4a35bb), fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RatingBarIndicator(
                                      rating: 1,
                                      itemCount: 5,
                                      itemSize: 35,
                                      unratedColor: Color(0xff9585ff),
                                      itemBuilder: (context,index) => Icon(
                                        Icons.star,
                                        color: Color(0xff1d00bd),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.download, size: 35, color: Color(0xff1d00bd)),
                                        Text(
                                            (state?.rented).toString(),
                                            style: GoogleFonts.alata(color: Color(0xff9585ff), fontSize: 20)
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Color(0xff9585ff),
                                  child: Text(
                                      (state?.synopsis).toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 8,
                                      style: GoogleFonts.alata(color: Color(0xff11005b), fontSize: 18),
                                  ),
                                )
                              ],
                            )
                    ),
                  ),
                ),
              ),
            )
        )
    );
  }
}
