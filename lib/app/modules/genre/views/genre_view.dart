import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/constant/global_color.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/base_64_converter.dart';
import '../controllers/genre_controller.dart';

class GenreView extends GetView<GenreController> {
  const GenreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: GlobalColor.soft,
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Icon(Icons.arrow_back, color: GlobalColor.soft),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Genre: ${Get.parameters['genre']}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.alata(
                            color: Colors.white,
                            fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
              width: Get.width,
              height: Get.height * 0.80,
              child: LiquidPullToRefresh(
                  color: GlobalColor.soft,
                  onRefresh: controller.getData,
                  showChildOpacityTransition: false,
                  child: Obx(() {
                    var state = controller.genreData.value;

                    if (state == null) {
                      return _template();
                    } else {
                      return GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 6,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL, parameters: {
                                  'id': state[index].id.toString()
                                });
                              },
                              child: Card(
                                  elevation: 5.0,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            child: Image(
                                              image: ImageConverter.base64ToImage(
                                                  state[index].book?.cover ?? '-'),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            )),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          state[index].book?.title ?? '-',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alata(
                                              color: GlobalColor.title,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Text(
                                          state[index].book?.publisher ?? '-',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alata(
                                              color: GlobalColor.subtitle,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 2, bottom: 10),
                                        child: state[index].book?.status ==
                                            'AVAILABLE'
                                            ? Text(
                                          state[index].book?.status ?? '-',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alata(
                                              color: CupertinoColors
                                                  .activeGreen,
                                              fontSize: 12),
                                        )
                                            : Text(
                                          state[index].book?.status ?? '-',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alata(
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                          itemCount: state.length);
                    }
                  }))),
        ]),
      ),
    );
  }

  Widget _template() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 6,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Shimmer.fromColors(
                  baseColor: const Color(0xffb6b6b6),
                  highlightColor: const Color(0xffffffff),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                          )),
                      Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(height: 20, width: 60, color: Colors.black)),
                      Container(
                          padding: const EdgeInsets.only(top: 7),
                          child: Container(height: 10, width: 60, color: Colors.black)),
                      Container(
                          padding: const EdgeInsets.only(top: 2, bottom: 10),
                          child:
                          Container(height: 10, width: 60, color: Colors.black))
                    ],
                  ),
                ),
              ));
        },
        itemCount: 21);
  }
}
