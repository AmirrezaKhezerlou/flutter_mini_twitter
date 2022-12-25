import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Views/twitt_list.dart';
import '../../CommonModule/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class NewTweet_Controller extends GetxController {
  TextEditingController Tweet_Controller = new TextEditingController();
  var FilePath;
  bool PickedImage = false;
  void Send_Tweet() async {
    if(!PickedImage){
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;

      var Value = {
        'UserName': prefs.getString('UserName'),
        'Message': Tweet_Controller.text,
        'SendTime': DateTime.now().toString(),
      };
      var Response = await http.post(Uri.parse(MainUrl+SendTwitteUrl), body: Value);
      if (Response.statusCode == 200) {
        Get.snackbar(
          'SENT !', 'Sent successfully',
          backgroundColor: Colors.green,
          icon: Icon(Icons.done_all,color: Colors.white,),
        );
        Get.off(
              () => Twitt_List(),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        Get.snackbar(
            'Error', 'Status Code is : ' + Response.statusCode.toString());
      }
    }else{
      //Send With Pic ...
    }

  }
}
