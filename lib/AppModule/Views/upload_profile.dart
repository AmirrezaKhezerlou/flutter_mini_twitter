import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/uploadprofile_controller.dart';

class upload_profile extends StatelessWidget {

  UploadProfileController upload_controller = Get.put(UploadProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()=> upload_controller.CheckPermission(),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(upload_controller.PlaceHolder.value),
                           fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Tap On The Blue Button To Select Your Profile Image')],
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
        title: Text('New Profile',style: TextStyle(color: Colors.black),),
      ),

      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(

          onPressed: (){
          upload_controller.CheckPermission();
          },
          child: Icon(Icons.cloud_upload_outlined,size: 40,),
          tooltip: 'Send Your Tweet :)',
        ),
      ),
    );
  }
}
