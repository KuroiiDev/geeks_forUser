import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: controller.obx((state) => ListView.builder(
          itemBuilder: (context, index){
            return Card(
              elevation: 5.0,
              child: ListTile(
                onTap: (){},
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                    child: Image.asset("assets/images/book_loading.png", fit: BoxFit.cover, width: 33, height: 44, alignment: Alignment.center,)
                ),
                title: Text(
                    '${state[index].title}',
                    style: GoogleFonts.alata(color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(
                    'Writer: ${state[index].writer}\nPublisher: ${state[index].publisher}\nYear: ${state[index].publishYear}',
                    style: GoogleFonts.alata(color: Colors.purple[200], fontSize: 13)),
                trailing: ElevatedButton(
                  child: Icon(Icons.bookmark),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15.0),
                    primary: Color(0xff8534ff),
                    elevation: 5,
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            );
          },
          itemCount: state!.length
      )),
    );
  }
}
