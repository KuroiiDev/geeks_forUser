import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/modules/account/views/account_view.dart';
import 'package:geek/app/modules/bookmark/views/bookmark_view.dart';
import 'package:geek/app/modules/home/views/home_view.dart';
import 'package:geek/app/modules/index/views/index_view.dart';

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
            bottomNavigationBar: _buildNavigationBar(),
            floatingActionButton: _buildFloatingButton(),
          );
        }
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: IndexedStack(
          index: controller.tabIndex,
          children: [
            BookmarkView(),
            HomeView(),
            AccountView(),
          ],
        )
    );
  }

  Widget _buildFloatingButton(){
    return FloatingActionButton(
      onPressed: (){
        Get.to(Get.toNamed(Routes.INDEX), transition: Transition.zoom);
      },
      child: Icon(Icons.list_alt),
      backgroundColor: Colors.deepPurple,
    );
  }

  Widget _buildNavigationBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.deepPurple,
      onTap: (index)=>controller.changeTabIndex(index),
      index: 1,
      items: [
        Icon(Icons.bookmark, color: Colors.white,),
        Icon(Icons.home, color: Colors.white,),
        Icon(Icons.person, color: Colors.white,),
      ],
    );
  }
}
