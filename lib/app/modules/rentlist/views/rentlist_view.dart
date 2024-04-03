import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../widgets/base_64.dart';
import '../controllers/rentlist_controller.dart';

class RentlistView extends GetView<RentlistController> {
  const RentlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent List'),
        backgroundColor: GlobalColor.soft,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: controller.obx((state) => LiquidPullToRefresh(
                  color: GlobalColor.soft,
                  onRefresh: controller.getData,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5.0,
                          child: ListTile(
                            onTap: ()=> Get.toNamed(Routes.RENT, parameters: {
                              'rent_id': (state[index].id).toString(),
                            }),
                            title: Text('${state[index].book?.title.toString()}',
                                style: GoogleFonts.alata(
                                    color: Colors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                'Date: ${state[index].rentDate}-${state[index].returnDate}\n${state[index].status}',
                                style: GoogleFonts.alata(
                                    color: Colors.purple[200], fontSize: 13)),
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
}