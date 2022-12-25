import 'package:story_viewer/story_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/imageview_controller.dart';

class image_view extends StatelessWidget {

ImageView_Controller controller = Get.put(ImageView_Controller());
final String Url;
final String UserName;

  image_view({super.key, required this.Url, required this.UserName});


  @override
  Widget build(BuildContext context) {
    return StoryViewer(
      fromAnonymous: true,
      hasReply: false,
      borderRadius: BorderRadius.circular(0),
      customValues: Customizer(seconds: '0'),
      backgroundColor: Colors.white,
      ratio: StoryRatio.r16_9,
      stories: [
        StoryItemModel(imageProvider: NetworkImage(Url)),
      ],
      onDispose:()=>controller.DisposeImageView,
      userModel: UserModel(
        username: UserName,
      ),
    );
  }
}
