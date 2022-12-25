import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Models/Login_Model.dart';
import 'package:mini_twitter/AppModule/Views/signup.dart';
import 'package:mini_twitter/AppModule/Views/twitt_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiModule/api_service.dart';

class SignIn_Controller extends GetxController {
  TextEditingController Email_Controller = new TextEditingController();
  TextEditingController Password_Controller = new TextEditingController();
  var LoginInfo = List<LoginModel>.empty().obs;
  RxBool IsLoading = false.obs;

  Future<void> Do_SignIn() async {
    try {
      IsLoading(true);
      var Infos =
          await Api_Service.fetch_Login(Email_Controller.text.toString());
      if (Infos.isNotEmpty) {
        LoginInfo.assignAll(Infos);
        print(LoginInfo.toString());
        if (LoginInfo[0].password == Password_Controller.text) {
          StoreData(LoginInfo[0].email,LoginInfo[0].userName);
        } else {
          Get.snackbar('خطا', 'رمز عبور ها همخوانی ندارند');
        }
      } else {
        Get.snackbar('خطا', 'حساب کاربری پیدا نشد');
      }
    } finally {
      IsLoading(false);
    }
  }

  void Go_SignUp() {
    Get.to(
      () => SignUp(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  void StoreData(String? Email , String? UserName)async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('UserName', UserName!);
    await prefs.setBool('Signed', true);
    await prefs.setString('Email', Email!);
    Go_Dashboard();
  }

  void Go_Dashboard(){
    Get.to(
          () => Twitt_List(),
      transition: Transition.rightToLeftWithFade,
    );
  }
}
