import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: FloatingActionButton.small(
              onPressed: () => controller.logout(),
              child: Icon(Icons.logout, color: GlobalColor.title),
              backgroundColor: Color(0xfff3f3f3),
              elevation: 0,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff7055f8), Color(0xffe3dbff), Color(0xfff3f3f3)]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            if (controller.accountData.value == null) {
              return Text('false');
            } else {
              var state = controller.accountData.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Container(
                      height: Get.width*0.45,
                      width: Get.width*0.45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 5),
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      (state?.name).toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: GoogleFonts.creteRound(
                          color: GlobalColor.title, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      (state?.email).toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: GoogleFonts.alata(
                          color: Colors.black87, fontSize: 18),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                            onPressed: ()=>Get.toNamed(Routes.RENTLIST),
                            child: Text('Rents')
                        ),
                        SizedBox(height: 30,),
                        ElevatedButton(
                            onPressed: (){},
                            child: Text('History')
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          }
        ),
      )
    ));
  }
}
