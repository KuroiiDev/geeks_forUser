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
              child: controller.obx((state) => LiquidPullToRefresh(
                key: controller.refreshKey,
                color: GlobalColor.soft,
                onRefresh: controller.getData,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5.0,
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL, parameters: {
                              'id': (state[index].id).toString(),
                            });
                          },
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image(
                                image: base64widget(state[index].cover ?? '-'),
                                fit: BoxFit.cover,
                                width: 33,
                                height: 44,
                                alignment: Alignment.center,
                              )),
                          title: Text('${state[index].title.toString()}',
                              style: GoogleFonts.alata(
                                  color: Colors.purple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Writer: ${state[index].writer}\nPublisher: ${state[index].publisher}\nYear: ${state[index].publishYear}\n${state[index].status}',
                              style: GoogleFonts.alata(
                                  color: Colors.purple[200], fontSize: 13)),
                          trailing: ElevatedButton(
                            child: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15.0),
                              backgroundColor: GlobalColor.soft,
                              elevation: 5,
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state!.length),
              )),
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
