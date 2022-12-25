import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Views/twitt_list.dart';
import '../../CommonModule/consts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadProfileController extends GetxController {

  RxString PlaceHolder = 'https://amirrezakhezerlou.ir/AndroidApps/MiniTwitter/user.png'
      .obs;


  void CheckPermission() async {
    if (await Permission.storage
        .request()
        .isGranted) {
      print('Permission is granted !');
      Pick();
    } else {
      await Permission.storage.request();
      CheckPermission();
    }
  }


  void Pick() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final File? file = File(image!.path);
    Upload(file!);
  }


  Upload(File imageFile) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    var stream = new http.ByteStream(
        DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(MainUrl + UploadProfile);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.fields["UserName"] = prefs.getString('UserName')!;
    var response = await request.send();
    print(response.statusCode);
    if(response.statusCode == 200){
      Get.to(()=>Twitt_List());
    }else{
      Get.snackbar('Error', 'Sorry Cant Upload Your New Profile' + response.statusCode.toString());
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}

