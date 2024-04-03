import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/data/constant/global_color.dart';
import 'package:geek/app/modules/account/views/account_view.dart';
import 'package:geek/app/modules/bookmark/views/bookmark_view.dart';
import 'package:geek/app/modules/home/views/home_view.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller){
          return Scaffold(
            body: _buildBody(),
            bottomNavigationBar: Obx(()=>_buildNavigationBar()),
            floatingActionButton: _buildFloatingButton(),
          );
        }
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: Obx(()=>PageView(
           controller: controller.pageController.value,
          children: [
            BookmarkView(),
            HomeView(),
            AccountView(),
          ],
          onPageChanged: (value){
             controller.tabIndex.value = value;
          },
        )
    ));
  }

  Widget _buildFloatingButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: FloatingActionButton(
        onPressed: (){
          Get.toNamed(Routes.INDEX);
        },
        child: Icon(Icons.list_alt, color: Colors.white, size: 25,),
        backgroundColor: Color(0xff5947ff),
        shape: CircleBorder()
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      decoration: BoxDecoration(

      ),
      child: CurvedNavigationBar(
        backgroundColor: Color(0xfff3f3f3),
        color: Color(0xff5947ff),
        onTap: (index)=>controller.changeTabIndex(index),
        index: controller.tabIndex.value,
        animationDuration: Duration(milliseconds: 200),
        buttonBackgroundColor: Color(0xff6f1bff),
        items: [
          _buildNavBarItem(Icons.bookmark),
          _buildNavBarItem(Icons.home),
          _buildNavBarItem(Icons.person),
        ],
      ),
    );
  }
  Widget _buildNavBarItem(IconData icon){
    return Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        )
    );
  }
}
