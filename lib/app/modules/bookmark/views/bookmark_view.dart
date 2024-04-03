import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Text(
            'Bookmark',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
