import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index){
          switch(index){
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark),
              label: "apalah"),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark),
              label: "itulah"),
        ],
      ),
    );
  }
}
