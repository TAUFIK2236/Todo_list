// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<Todo> todoFromJson(String str) => List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    this.id,
    this.title,
    this.description,
    this.isDone,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? description;
  bool? isDone;
  List<String>? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    isDone: json["isDone"],
    user: json["user"] == null ? [] : List<String>.from(json["user"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "isDone": isDone,
    "user": user == null ? [] : List<dynamic>.from(user!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
