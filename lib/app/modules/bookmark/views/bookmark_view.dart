import 'package:flutter/material.dart';
import 'package:geek/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/constant/global_color.dart';
import '../../../widgets/base_64.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(BookmarkController());
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xff7055f8),
            Color(0xffe3dbff),
            Color(0xfff3f3f3)
          ])),
      child: Container(
          width: Get.width,
          height: Get.height,
          child: Obx(() {
            var state = controller.bookmarkDetail.value;
            if (state == null){
              return _template();
            }else {
              return LiquidPullToRefresh(
                backgroundColor: Color(0xff7055f8),
                color: Colors.white,
                onRefresh: ()=>controller.getData(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 6,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Get.toNamed(Routes.DETAIL, parameters: {
                              'id' : (state[index].book?.id).toString(),
                            });
                          },
                          onLongPress: (){
                            controller.removeBookmark(state[index].id);
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
                                  Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: base64widget(state[index].book?.cover ?? '-'),
                                              fit: BoxFit.cover
                                          )
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        state[index].book?.title ?? '-',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.alata(
                                            color: GlobalColor.title,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
          })
      ),
    ));
  }

  Widget _template() {
    return LiquidPullToRefresh(
      backgroundColor: Color(0xff7055f8),
      color: Colors.white,
      onRefresh: ()=>controller.getData(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 6,
              crossAxisSpacing: 10.0,
            ),
            itemCount: 18,
            itemBuilder: (context, index) {
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Shimmer.fromColors(
                      baseColor: Color(0xffb6b6b6),
                      highlightColor: Color(0xffffffff),
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 20,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              );
            }),
      ),
    );
  }
}
