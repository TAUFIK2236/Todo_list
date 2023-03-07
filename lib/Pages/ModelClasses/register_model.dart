// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.name,
    this.username,
    this.password,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? name;
  String? username;
  String? password;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    name: json["name"],
    username: json["username"],
    password: json["password"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "password": password,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
