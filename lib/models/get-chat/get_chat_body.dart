// To parse this JSON data, do
//
//     final getChatBody = getChatBodyFromJson(jsonString);

import 'dart:convert';

GetChatBody getChatBodyFromJson(String str) => GetChatBody.fromJson(json.decode(str));

String getChatBodyToJson(GetChatBody data) => json.encode(data.toJson());

class GetChatBody {
  GetChatBody({
    required this.user1,
    required this.user2,
  });

  GCBUser user1;
  GCBUser user2;

  factory GetChatBody.fromJson(Map<String, dynamic> json) => GetChatBody(
    user1: GCBUser.fromJson(json["user1"]),
    user2: GCBUser.fromJson(json["user2"]),
  );

  Map<String, dynamic> toJson() => {
    "user1": user1.toJson(),
    "user2": user2.toJson(),
  };
}

class GCBUser {
  GCBUser({
    required this.accountId,
    required this.phone,
    required this.name,
    required this.birthday,
    required this.avatar,
    required this.id,
  });

  String accountId;
  String phone;
  String name;
  String birthday;
  String avatar;
  String id;

  factory GCBUser.fromJson(Map<String, dynamic> json) => GCBUser(
    accountId: json["account_id"],
    phone: json["phone"],
    name: json["name"],
    birthday: json["birthday"],
    avatar: json["avatar"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "phone": phone,
    "name": name,
    "birthday": birthday,
    "avatar": avatar,
    "_id": id,
  };
}
