import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/modules/account/views/account_view.dart';
import 'package:geek/app/modules/bookmark/views/bookmark_view.dart';
import 'package:geek/app/modules/home/views/home_view.dart';

import 'package:get/get.dart';
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
          );
        }
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: Obx(()=>PageView(
           controller: controller.pageController.value,
          children: const [
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

  Widget _buildNavigationBar() {
    return Container(
      decoration: const BoxDecoration(

      ),
      child: CurvedNavigationBar(
        backgroundColor: const Color(0xfff3f3f3),
        color: const Color(0xff5947ff),
        onTap: (index)=>controller.changeTabIndex(index),
        index: controller.tabIndex.value,
        animationDuration: const Duration(milliseconds: 200),
        buttonBackgroundColor: const Color(0xff6f1bff),
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
        padding: const EdgeInsets.all(5),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        )
    );
  }
}
