import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../data/constant/global_color.dart';
import '../controllers/genre_controller.dart';

class GenreView extends GetView<GenreController> {
  const GenreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: GlobalColor.soft,
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    SizedBox(width: 40)
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
                    var state = controller.bookData.value;

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
                                                  state[index].cover ?? '-'),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            )),
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
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Text(
                                          state[index].publisher ?? '-',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alata(
                                              color: GlobalColor.subtitle,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 2, bottom: 10),
                                        child: state[index].status ==
                                            'AVAILABLE'
                                            ? Text(
                                          state[index].status ?? '-',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alata(
                                              color: CupertinoColors
                                                  .activeGreen,
                                              fontSize: 12),
                                        )
                                            : Text(
                                          state[index].status ?? '-',
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
}
