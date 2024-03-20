import 'package:flutter/material.dart';
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
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: controller.obx(

                            (state) => Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height*0.45,
                                  width: double.infinity,
                                  child: ClipPath(
                                    clipper: CustomClipperWidget(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 60),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage('https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg'),
                                            fit: BoxFit.cover
                                          )
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
                                        style: GoogleFonts.alata(color: Color(0xff1d00bd), fontSize: 30, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        state?.writer ?? '-',
                                        style: GoogleFonts.alata(color: Color(0xff1d00bd), fontSize: 20),
                                      ),
                                    ],
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
