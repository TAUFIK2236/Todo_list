// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  LoginUser({
    this.username,
    this.sub,
    this.jwTtoken,
  });

  String? username;
  String? sub;
  String? jwTtoken;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    username: json["username"],
    sub: json["sub"],
    jwTtoken: json["JWTtoken"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "sub": sub,
    "JWTtoken": jwTtoken,
  };
}