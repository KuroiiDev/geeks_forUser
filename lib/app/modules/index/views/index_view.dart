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
            return Card(
              elevation: 5.0,
              child: ListTile(
                onTap: (){},
                leading: Icon(Icons.rectangle_rounded,size: 60),
                title: Text('${state[index].title}'),
                subtitle: Text('Writer: ${state[index].writer}'),
                trailing:
                    ElevatedButton(child: Icon(Icons.bookmark),onPressed: (){}),
              ),
            );
          },
          separatorBuilder: (context, index){
            return Divider(color: Colors.transparent,);
          },
          itemCount: state!.length
      )),
    );
  }
}
