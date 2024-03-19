import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
        child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Obx(() =>Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Id: ${controller.id}"),
                      Text("Title: ${controller.title}"),
                      Text("Writer: ${controller.writer}"),
                      Text("Publisher: ${controller.publisher}"),
                      Container(
                        height: 20,
                          width: 100,
                          child: Text("Synopsis: ${controller.synopsis}", overflow: TextOverflow.ellipsis,)
                      ),
                      Text("Status: ${controller.status}"),
                      Text("Rented Count: ${controller.rented}"),
                      Text("Publish Year: ${controller.publish_year}"),
                    ],
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("Rent")),
                      ElevatedButton(onPressed: (){}, child: Text("Bookmark")),
                    ],
                  )
                ]
            )
        ),
      ),
    );
  }
}
