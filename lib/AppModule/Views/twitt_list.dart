import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_twitter/AppModule/Controllers/twitteslist_controller.dart';
import 'package:mini_twitter/AppModule/Views/upload_profile.dart';
import '../../CommonModule/consts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Twitt_List extends StatelessWidget {
  const Twitt_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TwittesList_Controller _tw_Controller = Get.put(TwittesList_Controller());
    return Scaffold(
      backgroundColor: WhiteColor,
      body: SafeArea(
        child: Obx(
          () => ListView.builder(
            controller: _tw_Controller.scrollController,
              itemCount: _tw_Controller.TwittList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder<String>(
                              future: _tw_Controller.Fetch_Avatar(
                                  _tw_Controller.TwittList[index].userName),
                              initialData: 'https://amirrezakhezerlou.ir/AndroidApps/MiniTwitter/user.png',
                              builder: (context, snapshot) {
                                return InkWell(
                                  onTap: (){
                                    if(snapshot.hasData){
                                      _tw_Controller.ShowProfile(_tw_Controller.TwittList[index].userName,
                                        snapshot.data!,
                                      );
                                    }
                                  },
                                  child: CachedNetworkImage(
                                    width: 50,
                                    height: 50,
                                    imageUrl: snapshot.data!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(width: 10,),
                          Text('@' + _tw_Controller.TwittList[index].userName),
                          Spacer(),
                          Text(
                            _tw_Controller.Get_TimeAgo(DateTime.parse(
                              _tw_Controller.TwittList[index].sendTime,
                            )),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                                    _tw_Controller.TwittList[index].message,
                                textAlign: TextAlign.end,)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            FontAwesomeIcons.comment,
                            size: 30,
                          ),
                          GestureDetector(
                              onTap: () => _tw_Controller.SendReTweet(
                                  _tw_Controller.TwittList[index].message),
                              child: Icon(
                                FontAwesomeIcons.retweet,
                                size: 25,
                              )),
                          FutureBuilder<List>(
                              future: _tw_Controller.Fetch_Likes(
                                  _tw_Controller.TwittList[index].id),
                              initialData: [0, '0'],
                              builder: (context, snapshot) {
                                return LikeButton(
                                  likeCount: snapshot.data?[0],
                                  isLiked:
                                      snapshot.data?[1] == '1' ? true : false,
                                  onTap: (state) {
                                    return _tw_Controller.onLikeButtonTapped(
                                        state,
                                        _tw_Controller.TwittList[index].id);
                                  },
                                );
                              }),
                          GestureDetector(
                              onTap: () => _tw_Controller.ShareText(
                                  _tw_Controller.TwittList[index].message),
                              child: Icon(
                                Icons.share,
                                size: 30,
                              )),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tw_Controller.Write_New_Tweet();
        },
        elevation: 3,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Container(
          child: GestureDetector(
            onTap: ()=>Get.to(()=>upload_profile()),
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
