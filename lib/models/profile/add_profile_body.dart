// To parse this JSON data, do
//
//     final addProfileBody = addProfileBodyFromJson(jsonString);

import 'dart:convert';

AddProfileBody addProfileBodyFromJson(String str) => AddProfileBody.fromJson(json.decode(str));

String addProfileBodyToJson(AddProfileBody data) => json.encode(data.toJson());

class AddProfileBody {
  AddProfileBody({
    required this.name,
    required this.birthday,
    required this.avatar,
  });

  String name;
  String birthday;
  String avatar;

  factory AddProfileBody.fromJson(Map<String, dynamic> json) => AddProfileBody(
    name: json["name"],
    birthday: json["birthday"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "birthday": birthday,
    "avatar": avatar,
  };
}
