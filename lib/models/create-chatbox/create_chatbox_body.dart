// To parse this JSON data, do
//
//     final createChatboxBody = createChatboxBodyFromJson(jsonString);

import 'dart:convert';

CreateChatboxBody createChatboxBodyFromJson(String str) => CreateChatboxBody.fromJson(json.decode(str));

String createChatboxBodyToJson(CreateChatboxBody data) => json.encode(data.toJson());

class CreateChatboxBody {
  CreateChatboxBody({
    required this.user1,
    required this.user2,
  });

  CCBUser user1;
  CCBUser user2;

  factory CreateChatboxBody.fromJson(Map<String, dynamic> json) => CreateChatboxBody(
    user1: CCBUser.fromJson(json["user1"]),
    user2: CCBUser.fromJson(json["user2"]),
  );

  Map<String, dynamic> toJson() => {
    "user1": user1.toJson(),
    "user2": user2.toJson(),
  };
}

class CCBUser {
  CCBUser({
    required this.accountId,
    required this.phone,
    required this.name,
    required this.birthday,
    required this.avatar,
  });

  String accountId;
  String phone;
  String name;
  String birthday;
  String avatar;

  factory CCBUser.fromJson(Map<String, dynamic> json) => CCBUser(
    accountId: json["account_id"],
    phone: json["phone"],
    name: json["name"],
    birthday: json["birthday"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "phone": phone,
    "name": name,
    "birthday": birthday,
    "avatar": avatar,
  };
}
