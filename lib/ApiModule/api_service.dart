import 'package:http/http.dart' as http;
import 'package:mini_twitter/AppModule/Models/Like_Model.dart';
import '../AppModule/Models/AvatarModel.dart';
import '../CommonModule/consts.dart';
import '../AppModule/Models/Twittes_Model.dart';
import '../AppModule/Models/Login_Model.dart';

class Api_Service {
  static var client = http.Client();
  static Future<List<TwittesModel>> fetch_Twittes(String From) async {
    var Values = {
      'from' : From,
    };
    var response = await client.post(Uri.parse(MainUrl + GetTwittesUrl),body: Values);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return twittesModelFromJson(jsonString);
    } else {
      return [];
    }
  }

  static Future<List<LoginModel>> fetch_Login(String EmailAddress) async {
    var Values = {'Email': EmailAddress};
    var response = await client.post(Uri.parse(MainUrl+SignInUrl), body: Values);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return loginModelFromJson(jsonString);
    } else {
      return [];
    }
  }


  static Future<List<AvatarModel>> fetch_avatar(String UserName) async {
    var Values = {'UserName': UserName};
    var response = await client.post(Uri.parse(MainUrl+GetUserAvatarUrl), body: Values);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return avatarModelFromJson(jsonString);
    } else {
      return [];
    }
  }


  static Future<List<LikeModel>> fetch_like(String PostId) async {
    var Values = {'PostId': PostId};
    var response = await client.post(Uri.parse(MainUrl+GetLikesList), body: Values);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return likeModelFromJson(jsonString);
    } else {
      return [];
    }
  }



}
