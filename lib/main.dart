import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Views/splash.dart';
import 'package:mini_twitter/AppModule/Views/upload_profile.dart';
import 'AppModule/Views/signup.dart';
import 'AppModule/Views/twitt_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'iransans'
      ),
      home: Splash_Screen(),
    );
  }
}

