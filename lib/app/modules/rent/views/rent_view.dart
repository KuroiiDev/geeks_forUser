import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rent_controller.dart';

class RentView extends GetView<RentController> {
  const RentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RentView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx((){
          if (controller.rentData.value == null) {
            return Text('Kosong');
          }else {
            var state = controller.rentData.value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(state?.book?.title ?? '-'),
                Text(state?.user?.name ?? '-'),
              ],
            );
          }
        })
      ),
    );
  }
}
