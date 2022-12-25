// To parse this JSON data, do
//
//     final twittesModel = twittesModelFromJson(jsonString);

import 'dart:convert';

List<TwittesModel> twittesModelFromJson(String str) => List<TwittesModel>.from(json.decode(str).map((x) => TwittesModel.fromJson(x)));

String twittesModelToJson(List<TwittesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TwittesModel {
  TwittesModel({
    required this.id,
    required this.userName,
    required this.message,
    required this.sendTime,
  });

  String id;
  String userName;
  String message;
  String sendTime;

  factory TwittesModel.fromJson(Map<String, dynamic> json) => TwittesModel(
    id: json["id"],
    userName: json["UserName"],
    message: json["Message"],
    sendTime: json["SendTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "UserName": userName,
    "Message": message,
    "SendTime": sendTime,
  };
}
