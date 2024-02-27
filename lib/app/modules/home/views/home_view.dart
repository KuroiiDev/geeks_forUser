import 'package:flutter/material.dart';
import 'package:geek/app/widgets/custom_navbar.dart';

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
      bottomNavigationBar: CustomNavbar(indexNum: 1)
    );
  }
}
