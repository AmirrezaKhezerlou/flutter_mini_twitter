import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Models/AvatarModel.dart';
import 'package:mini_twitter/AppModule/Models/Like_Model.dart';
import 'package:mini_twitter/AppModule/Models/Twittes_Model.dart';
import 'package:mini_twitter/AppModule/Views/image_view.dart';
import '../../ApiModule/api_service.dart';
import '../Views/new_tweet.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../CommonModule/consts.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class TwittesList_Controller extends GetxController {

  @override
  void onInit() {
    print(DateTime.now());
    Fetch_All_Twittes('0');

    super.onInit();
  }
  var From = 0.obs;
  var isLoading = true.obs;
  var TwittList = List<TwittesModel>.empty().obs;
  var AvatarList = List<AvatarModel>.empty().obs;
  var LikesList = List<LikeModel>.empty().obs;
  var scrollController = ScrollController();





  void Fetch_All_Twittes(String Frome) async {
    try {
      isLoading(true);
      var Twittes = await Api_Service.fetch_Twittes(Frome);
      if (Twittes != null) {
        TwittList.addAll(Twittes);
        scrollController.addListener(() {
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            From+5;
            Fetch_All_Twittes(From.toString());
          }
        });
      } else {
        print('Twittes is null !');
      }
    } finally {
      isLoading(false);
    }


  }

  Future<String> Fetch_Avatar(String UserName) async {
    var Avatar = await Api_Service.fetch_avatar(UserName);
    if (Avatar != null) {
      AvatarList.assignAll(Avatar);
      return AvatarList[0].avatar;
    } else {
      return 'Place Holder Image Will Be Shown Soon !';
    }
  }

  String Get_TimeAgo(DateTime Date) {
    return GetTimeAgo.parse(Date);
  }

  void Write_New_Tweet() {
    Get.off(
      () => New_Tweet(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  Future<List<dynamic>> Fetch_Likes(String PostId) async {
    //[34 , '0'];
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var Like_Count = 0.obs;
    RxList Result = [].obs;
    var Like = await Api_Service.fetch_like(PostId);
    if (Like != null) {
      LikesList.assignAll(Like);
      Like_Count.value = LikesList.length;
      Result.add(Like_Count.value);
      String MyUserName = prefs.getString('UserName')!;
      LikesList.forEach((element) {
        if (element.userName == MyUserName) {
          Result.add('1');
        }
      });
      if (Result.length == 1) {
        Result.add('0');
      }
      return Result;
    } else {
      return [];
    }
  }

  Future<bool> onLikeButtonTapped(bool isLiked,String PostId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String UserName = prefs.getString('UserName')!;
    if (isLiked == false) {
      print('Started Liking ...');
      //Like
      var Values = {
        'Post_Id' : PostId,
        'UserName' : UserName,
        'Date': DateTime.now().toString(),
      };
      
      var Response = await http.post(Uri.parse(MainUrl + SetLike),body: Values);
      if(Response.statusCode == 200 ){
        print(Response.statusCode.toString() + Response.body);
        if(Response.body =='Sent Message Was Seccessful'){
          return !isLiked;
        }
      }
    } else {
      print('starting deleting like ...');
      var Values = {
        'UserName' : UserName,
        'PostId' : PostId,
      };

      var Response = await http.post(Uri.parse(MainUrl + UnLikeUrl),body: Values);
      print(Response.body);
      if(Response.statusCode == 200 ){

        if(Response.body =='Deleted'){
          return !isLiked;
        }
      }

      return !isLiked;
    }
    return isLiked;
  }

  void SendReTweet(String Message) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    var Value = {
      'UserName': prefs.getString('UserName'),
      'Message': Message,
      'SendTime': DateTime.now().toString(),
    };
    var Response = await http.post(Uri.parse(MainUrl+SendTwitteUrl), body: Value);
    if (Response.statusCode == 200) {
      Get.snackbar(
        'SENT !', 'Retweeted successfully',
        backgroundColor: Colors.green,
        icon: Icon(Icons.done_all,color: Colors.white,),
      );
      TwittList.clear();
      Fetch_All_Twittes('0');
    } else {
      Get.snackbar(
          'Error', 'Status Code is : ' + Response.statusCode.toString());
    }
  }


  Future<void> ShareText(String Message) async {
    await Share.share(Message);
    Get.snackbar(
        'Share!', 'Message Shared!');
  }


  void ShowProfile(String UserName , String Url){
    Get.to(() => image_view(Url: Url, UserName: UserName));
  }

}




