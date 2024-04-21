import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../data/constant/global_color.dart';
import '../../../widgets/base_64_converter.dart';
import '../../../widgets/custom_clipper.dart';
import '../controllers/rent_controller.dart';

class RentView extends GetView<RentController> {
  const RentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: Obx(() {
        var state = controller.rentData.value;
        if (state == null) {
          return const Text('Kosong');
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
                              image: ImageConverter.base64ToImage(state.book?.cover ?? '-'),
                              fit: BoxFit.cover,
                              opacity: 450)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 5, color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                  ImageConverter.base64ToImage(state.book?.cover ?? '-'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  )),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    state.book?.title ?? '-',
                    style: GoogleFonts.alata(
                        color: GlobalColor.title,
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.book?.writer ?? '-',
                    style: GoogleFonts.alata(
                        color: GlobalColor.subtitle, fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: GlobalColor.soft)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rent: ${(state.rentDate ?? '-').toString()}',
                      style: GoogleFonts.alata(
                          color: GlobalColor.subtitle,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Return: ${(state.returnDate ?? '-').toString()}',
                      style: GoogleFonts.alata(
                          color: GlobalColor.subtitle,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(width: 1, color: GlobalColor.soft)),
                  ),
                  child: Center(
                    child: (state.status).toString() != "RETURNED"
                        ? false
                            ? SizedBox(
                                width: Get.width * 0.8,
                                height: Get.width * 0.8,
                                child: PrettyQrView.data(
                                  data: (state.id).toString(),
                                  decoration: const PrettyQrDecoration(
                                      shape: PrettyQrSmoothSymbol(
                                          color: Color(0xff7b63ff))),
                                ),
                              )
                            : Column(
                              children: [
                                Text(
                                    ('Rent Code: ').toString(),
                                    //hi
                                    style: GoogleFonts.alata(
                                        color: GlobalColor.subtitle,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                Text(
                                  (state.id ?? '-').toString(),
                                  style: GoogleFonts.alata(
                                      color: GlobalColor.soft,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                        : Text(
                            (state.status ?? '-').toString(),
                            style: GoogleFonts.alata(
                                color: GlobalColor.subtitle,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                  )),
              const SizedBox(height: 35),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Rate This Book',
                    style: GoogleFonts.alata(
                        color: GlobalColor.subtitle,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    itemCount: 5,
                    itemSize: 45,
                    unratedColor: Colors.black26,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: GlobalColor.softDeep,
                    ),
                    onRatingUpdate: (double value) {
                      controller.ratingVal = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: ()=>controller.rating(state.book?.id.toString()),
                    label: Text("Submit", style: GoogleFonts.alata(color: Colors.white, fontSize: 20)),
                    icon: const Icon(Icons.transit_enterexit, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      backgroundColor: GlobalColor.softDeep,
                      elevation: 5,
                      shape: const StadiumBorder(),
                    ),
                  )
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
              )
            ],
          );
        }
      })),
    );
  }
}
