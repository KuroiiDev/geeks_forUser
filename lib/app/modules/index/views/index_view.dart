import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Index'),
        centerTitle: true,
      ),
      body: controller.obx((state) => ListView.separated(
          itemBuilder: (context, index){
            return ListTile(
              title: Text('${state[index].title}'),
              subtitle: Text('Writer: ${state[index].writer}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(child: Text("Rent"),onPressed: (){}),
                  ElevatedButton(child: Icon(Icons.bookmark),onPressed: (){}),
                ]
              ),
            );
          },
          separatorBuilder: (context, index){
            return Divider();
          },
          itemCount: state!.length
      )),
    );
  }
}
