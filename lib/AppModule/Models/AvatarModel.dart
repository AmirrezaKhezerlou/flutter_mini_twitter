// To parse this JSON data, do
//
//     final avatarModel = avatarModelFromJson(jsonString);

import 'dart:convert';

List<AvatarModel> avatarModelFromJson(String str) => List<AvatarModel>.from(json.decode(str).map((x) => AvatarModel.fromJson(x)));

String avatarModelToJson(List<AvatarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvatarModel {
  AvatarModel({
    required this.avatar,
  });

  String avatar;

  factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
    avatar: json["Avatar"],
  );

  Map<String, dynamic> toJson() => {
    "Avatar": avatar,
  };
}
