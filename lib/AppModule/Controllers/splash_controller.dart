import 'dart:async';
import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Views/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Views/twitt_list.dart';


class Splash_Controller extends GetxController
{
  int splashTime = 5;
  void StartTimer()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if(prefs.containsKey('Signed')){
      Timer(Duration(seconds: splashTime), () {
        Get.to(()=>Twitt_List(),
          transition: Transition.rightToLeftWithFade,
        );
      });
    }else{
      Timer(Duration(seconds: splashTime), () {
        Get.to(()=>SignUp(),
          transition: Transition.rightToLeftWithFade,
        );
      });

    }

  }

  @override
  void onInit() {
    StartTimer();
    super.onInit();
  }

}