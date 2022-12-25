import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/newtweet_controller.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class New_Tweet extends StatelessWidget {
  NewTweet_Controller _newTweet_Controller = Get.put(NewTweet_Controller());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height/2,
                child: Sign_Fields(
                    hint: 'Whats happening?',
                    MyController: _newTweet_Controller.Tweet_Controller),
              ),

              Container(
                padding: EdgeInsets.only(right: 20,left: 20),
                child: Row(
                  children: [
                    ImagePickerWidget(
                      diameter: 100,
                      initialImage: "https://strattonapps.com/wp-content/uploads/2020/02/flutter-logo-5086DD11C5-seeklogo.com_.png",
                      shape: ImagePickerWidgetShape.square, // ImagePickerWidgetShape.square
                      isEditable: true,
                      modalOptions: ModalOptions(

                      ),
                      imagePickerOptions: ImagePickerOptions(
                        imageQuality: 50
                      ),
                      onChange: (File file) {
                        print("I changed the file to: ${file.path}");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('New Tweet!',style: TextStyle(color: Colors.black),),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _newTweet_Controller.Send_Tweet();
        },
        child: Icon(Icons.send),
        tooltip: 'Send Your Tweet :)',
      ),
    );
  }
}

class Sign_Fields extends StatelessWidget {

  const Sign_Fields({
    Key? key,
    required this.hint,
    required this.MyController,
  });

  final TextEditingController MyController;
  final String hint;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        maxLines: (height/24).toInt(),
        controller: MyController,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          iconColor: Colors.white,
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
