// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) => List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(List<LoginModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  LoginModel({
    required this.userName,
    required this.email,
    required this.password,
  });

  String userName;
  String email;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    userName: json["UserName"],
    email: json["Email"],
    password: json["Password"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "Email": email,
    "Password": password,
  };
}
