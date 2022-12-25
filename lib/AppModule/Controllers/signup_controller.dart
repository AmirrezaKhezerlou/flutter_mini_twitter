import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_twitter/AppModule/Views/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_twitter/AppModule/Views/twitt_list.dart';
import '../../CommonModule/consts.dart';

class SignUp_Controller extends GetxController {

  TextEditingController UserName_Controller = new TextEditingController();
  TextEditingController Email_Controller = new TextEditingController();
  TextEditingController Password_Controller = new TextEditingController();

  void DoSignUp() async {
    var values = {
      'UserName': UserName_Controller.text,
      'Password': Password_Controller.text,
      'Email': Email_Controller.text,
    };
    var Response = await http.post(
      Uri.parse(MainUrl + SignUpUrl),
      body: values,
    );
    if (Response.statusCode == 200) {
      if (Response.body == UserName_Controller.text) {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        await prefs.setBool('Signed', true);
        await prefs.setString('UserName', UserName_Controller.text.toString());
        await prefs.setString('Email', Email_Controller.text.toString());
        Get.to(
          () => Twitt_List(),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        Get.snackbar(
            'خطا', 'خطایی رخ داده است :' + Response.statusCode.toString());
      }
    }
  }

  void Go_SignIn() {
    Get.to(
      () => Signin(),
      transition: Transition.rightToLeftWithFade,
    );
  }
}
