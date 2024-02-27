import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geek/app/routes/app_pages.dart';
import 'package:get/get.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key, required this.indexNum});
  final int indexNum;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.deepPurple,
      onTap: (index){
        switch (index) {
          case 0:
            break;
          case 1:
            Get.toNamed(Routes.HOME);
            break;
          case 2:
            Get.toNamed(Routes.ACCOUNT);
            break;
        }
      },
      index: indexNum,
      items: [
        Icon(Icons.book),
        Icon(Icons.home),
        Icon(Icons.person),

      ],
    );
  }
}
