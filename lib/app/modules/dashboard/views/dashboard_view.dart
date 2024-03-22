import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
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
    return FloatingActionButton(
      onPressed: (){
        Get.toNamed(Routes.INDEX);
      },
      child: Icon(Icons.list_alt, color: Colors.white),
      backgroundColor: Color(0xff5947ff),
    );
  }

  Widget _buildNavigationBar() {
    return Container(

      child: CurvedNavigationBar(
        backgroundColor: Color(0xff11005b),
        color: Color(0xff5947ff),
        onTap: (index)=>controller.changeTabIndex(index),
        index: controller.tabIndex.value,
        animationDuration: Duration(milliseconds: 200),
        items: [
          _buildNavBarItem(Icon(Icons.bookmark, color: Colors.white)),
          _buildNavBarItem(Icon(Icons.home, color: Colors.white)),
          _buildNavBarItem(Icon(Icons.person, color: Colors.white)),
        ],
      ),
    );
  }
  Widget _buildNavBarItem(Icon icon){
    return Padding(
        padding: EdgeInsets.all(5),
        child: icon
    );
  }
}
