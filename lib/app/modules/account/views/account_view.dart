import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/base_64.dart';
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
                    text:
                        'By clicking Logout, you have to Login again to access the main Menu',
                    confirmBtnText: 'Logout',
                    title: 'Leaving Already?',
                    cancelBtnText: 'Stay',
                    confirmBtnColor: Colors.red,
                    animType: QuickAlertAnimType.scale,
                  );
                },
                backgroundColor: Color(0xfff3f3f3),
                elevation: 0,
                shape: CircleBorder(),
                child: Icon(Icons.logout, color: GlobalColor.title))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(() {
                if (controller.accountData.value == null) {
                  return _template();
                } else {
                  var state = controller.accountData.value;
                  var rent = controller.rentData.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Container(
                          height: Get.width * 0.45,
                          width: Get.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 5),
                              shape: BoxShape.circle),
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
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: GlobalColor.soft, width: 2))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Book You currently Rented',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.creteRound(
                                  fontSize: 20,
                                  color: GlobalColor.darkTitle,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                )),
                            SizedBox(height: 10),
                            rent != null
                                ? GestureDetector(
                                    onTap: () =>
                                        Get.toNamed(Routes.RENT, parameters: {
                                          'rent_id': (rent.id).toString(),
                                        }),
                                    child: Card(
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      color: Colors.white,
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        width: Get.width * 0.90,
                                        //height: 200,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Card(
                                                elevation: 5.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                child: Container(
                                                  height: 180,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: GlobalColor
                                                              .darkTitle),
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: base64widget(
                                                              rent.book
                                                                      ?.cover ??
                                                                  '-'))),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: Get.width * 0.45,
                                                      child: Text(
                                                          rent.book?.title ??
                                                              "-",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: GoogleFonts
                                                              .creteRound(
                                                                  fontSize: 25,
                                                                  color:
                                                                      GlobalColor
                                                                          .title,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  letterSpacing:
                                                                      1)),
                                                    ),
                                                    Text(
                                                      'Must be Returned On:',
                                                      style: GoogleFonts.alata(
                                                          color: GlobalColor
                                                              .softDeep,
                                                          fontSize: 15),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Text(
                                                      rent.returnDate ?? '-',
                                                      style: GoogleFonts.alata(
                                                          color:
                                                              Colors.red
                                                          ,
                                                          fontSize: 15),
                                                      textAlign: TextAlign.left,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                : Card(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    color: Colors.white,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30),
                                      width: Get.width * 0.90,
                                      child: Center(
                                        child: Text(
                                          'No Book Currently Rented..',
                                          style: GoogleFonts.alata(
                                              color: GlobalColor.soft,
                                              fontSize: 20),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    )),
                            SizedBox(height: 50),
                            ElevatedButton.icon(
                              onPressed: () => Get.toNamed(Routes.RENTLIST),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 40),
                                elevation: 20,
                                backgroundColor: Colors.white,
                              ),
                              icon: Icon(
                                Icons.history,
                                color: GlobalColor.subtitle,
                                size: 30,
                              ),
                              label: Text("History",
                                  style: GoogleFonts.alata(
                                      color: GlobalColor.subtitle,
                                      fontSize: 25)),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 40),
                                elevation: 20,
                                backgroundColor: Colors.white,
                              ),
                              icon: Icon(
                                Icons.edit,
                                color: GlobalColor.subtitle,
                                size: 30,
                              ),
                              label: Text("Edit Profile",
                                  style: GoogleFonts.alata(
                                      color: GlobalColor.subtitle,
                                      fontSize: 25)),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
            ),
          ),
        ));
  }

  Widget _template() {
    return Shimmer.fromColors(
      baseColor: Color(0xffb6b6b6),
      highlightColor: Color(0xffffffff),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              height: Get.width * 0.45,
              width: Get.width * 0.45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 5),
                  shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 30,
              width: Get.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 25,
              width: Get.width * 0.50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: Get.width * 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  width: Get.width * 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
