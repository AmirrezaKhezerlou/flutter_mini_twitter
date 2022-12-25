import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_twitter/AppModule/Controllers/splash_controller.dart';
import '../../CommonModule/consts.dart';

class Splash_Screen extends StatelessWidget {

  Splash_Controller _splash_controller = Get.put(Splash_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Blue_Color,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Icon(Icons.message,color: WhiteColor,size: 90,),
              ),
            ),
            CircularProgressIndicator(color: WhiteColor,),
          ],
        ),
      ),

    );
  }
}
