import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/genre_controller.dart';

class GenreView extends GetView<GenreController> {
  const GenreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genre Book'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GenreView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
