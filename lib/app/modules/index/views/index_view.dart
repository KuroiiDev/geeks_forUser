import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/widgets/base_64.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../routes/app_pages.dart';
import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: GlobalColor.soft,
              child: Padding(
                  padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: ()=> Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                        ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            child: Icon(Icons.arrow_back, color: GlobalColor.soft),
                          ),
                      ),
                      _buildSearchBox(),
                    ],
                  )
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height *0.80,
              child: Obx(() {
                var state = controller.bookData.value;

                if (state == null){
                  return Text('null');
                } else {
                  return LiquidPullToRefresh(
                    key: controller.refreshKey,
                    color: GlobalColor.soft,
                    onRefresh: controller.getData,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 6,
                          crossAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL, parameters: {
                                'id' : state[index].id.toString()
                              });
                            },
                            child: Card(
                              elevation: 5.0,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: base64widget(state[index].cover ?? '-'),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        )
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
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
                                    padding: EdgeInsets.only(top: 7),
                                    child: Text(
                                      state[index].publisher ?? '-',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.alata(
                                          color: GlobalColor.subtitle,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 2, bottom: 10),
                                    child: state[index].status == 'AVAILABLE' ?
                                    Text(
                                      state[index].status ?? '-',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.alata(
                                          color: CupertinoColors.activeGreen,
                                          fontSize: 12),
                                    )
                                    :
                                    Text(
                                      state[index].status ?? '-',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.alata(
                                          color: Colors.red,
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              )
                            ),
                          );
                        },
                        itemCount: state.length),
                  );
                }
              }),
            ),
          ]),
      ),
    );
  }
  Widget _buildSearchBox() {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(children: [
          Icon(Icons.search),
          Container(
            width: 250,
            child: TextFormField(
              onFieldSubmitted: (query)=>Get.snackbar("Not Found", "can't find book: $query", backgroundColor: GlobalColor.soft),
              controller: controller.searchController,
              style: GoogleFonts.alata(fontSize: 20),
              focusNode: controller.searchBar,
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
}
