import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: FloatingActionButton.small(
              onPressed: () {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    showCancelBtn: true,
                    showConfirmBtn: true,
                    onConfirmBtnTap: () => controller.logout(),
                    text: 'By clicking Logout, you have to Login again to access the main Menu',
                    confirmBtnText: 'Logout',
                    title: 'Leaving Already?',
                    cancelBtnText: 'Stay',
                    confirmBtnColor: Colors.red,
                    animType: QuickAlertAnimType.scale,
                );
              },
              child: Icon(Icons.logout, color: GlobalColor.title),
              backgroundColor: Color(0xfff3f3f3),
              elevation: 0,
              shape: CircleBorder()
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
        child: SingleChildScrollView(
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
                          GestureDetector(
                              onTap: (){},
                              child: Card(
                                elevation: 20,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                                color: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  width: Get.width *0.8,
                                  height: 300,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 50),
                          ElevatedButton.icon(
                              onPressed: ()=>Get.toNamed(Routes.RENTLIST),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
                                elevation: 20,
                                backgroundColor: Colors.white,
                              ),
                            icon: Icon(Icons.history, color: GlobalColor.subtitle, size: 30,),
                            label: Text("History", style: GoogleFonts.alata(color: GlobalColor.subtitle, fontSize: 25)),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
                              elevation: 20,
                              backgroundColor: Colors.white,
                            ),
                            icon: Icon(Icons.edit, color: GlobalColor.subtitle, size: 30,),
                            label: Text("Edit Profile", style: GoogleFonts.alata(color: GlobalColor.subtitle, fontSize: 25)),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            }
          ),
                ),
        )
    ));
  }
}
