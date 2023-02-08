// To parse this JSON data, do
//
//     final addProfileBody = addProfileBodyFromJson(jsonString);

import 'dart:convert';

AddProfileBody addProfileBodyFromJson(String str) => AddProfileBody.fromJson(json.decode(str));

String addProfileBodyToJson(AddProfileBody data) => json.encode(data.toJson());

class AddProfileBody {
  AddProfileBody({
    required this.phone,
    required this.name,
    required this.birthday,
    required this.avatar,
  });

  String phone;
  String name;
  String birthday;
  String avatar;

  factory AddProfileBody.fromJson(Map<String, dynamic> json) => AddProfileBody(
    phone: json["phone"],
    name: json["name"],
    birthday: json["birthday"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "name": name,
    "birthday": birthday,
    "avatar": avatar,
  };
}
