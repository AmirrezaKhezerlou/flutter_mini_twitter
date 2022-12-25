import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Controllers/signup_controller.dart';
import '../../CommonModule/consts.dart';

class SignUp extends StatelessWidget {

  SignUp_Controller _signUp_Controller = Get.put(SignUp_Controller());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Blue_Color,
          statusBarIconBrightness:
          Brightness.dark,
          statusBarBrightness:
          Brightness.light,
        ),
      ),
      backgroundColor: Blue_Color,
      body: Container(
        margin: EdgeInsets.only(right: 20,left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderImage(),
            Column(
              children: [
                Sign_Fields(
                  hint: 'Email',
                  icon: Icon(Icons.email_outlined),
                  MyController: _signUp_Controller.Email_Controller,
                ),
                Sign_Fields(
                  hint: 'UserName',
                  icon: Icon(Icons.person_outline_outlined),
                  MyController: _signUp_Controller.UserName_Controller,
                ),
                Sign_Fields(
                  hint: 'Password',
                  icon: Icon(Icons.password),
                  MyController: _signUp_Controller.Password_Controller,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: (){
                  _signUp_Controller.DoSignUp();
                },
              style:ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.only(right: 40,left: 40,top: 20,bottom: 20),),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                         
                      ),
                  ),
              ),
                child: Text('SignUp',style: TextStyle(color: Colors.black),),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: ()=>_signUp_Controller.Go_SignIn(),
                  child: Text('Or login if you already have an account.',
                    style: TextStyle(color: WhiteColor),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Sign_Fields extends StatelessWidget {
  const Sign_Fields({
    Key? key,
    required this.hint,
    required this.icon,
    required this.MyController,
  });

  final TextEditingController MyController;
  final String hint;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        controller: MyController,
        decoration: InputDecoration(
          fillColor: WhiteColor,
          filled: true,
          iconColor: WhiteColor,
          prefixIcon: icon,
          prefixIconColor: Blue_Color,
          hintText: hint,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
        ),
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: WhiteColor),
          ),
          child: Icon(
            Icons.message,
            color: WhiteColor,
            size: 45,
          ),
        ),
      ],
    );
  }
}