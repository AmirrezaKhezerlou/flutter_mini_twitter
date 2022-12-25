// To parse this JSON data, do
//
//     final likeModel = likeModelFromJson(jsonString);

import 'dart:convert';

List<LikeModel> likeModelFromJson(String str) => List<LikeModel>.from(json.decode(str).map((x) => LikeModel.fromJson(x)));

String likeModelToJson(List<LikeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LikeModel {
  LikeModel({
    required this.userName,
  });

  String userName;

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
    userName: json["UserName"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
  };
}
