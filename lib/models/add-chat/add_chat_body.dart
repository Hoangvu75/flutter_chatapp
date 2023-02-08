// To parse this JSON data, do
//
//     final addChatBody = addChatBodyFromJson(jsonString);

import 'dart:convert';

AddChatBody addChatBodyFromJson(String str) => AddChatBody.fromJson(json.decode(str));

String addChatBodyToJson(AddChatBody data) => json.encode(data.toJson());

class AddChatBody {
  AddChatBody({
    required this.user1,
    required this.user2,
    required this.sender,
    required this.content,
    required this.time,
  });

  ACBUser user1;
  ACBUser user2;
  String sender;
  String content;
  String time;

  factory AddChatBody.fromJson(Map<String, dynamic> json) => AddChatBody(
    user1: ACBUser.fromJson(json["user1"]),
    user2: ACBUser.fromJson(json["user2"]),
    sender: json["sender"],
    content: json["content"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "user1": user1.toJson(),
    "user2": user2.toJson(),
    "sender": sender,
    "content": content,
    "time": time,
  };
}

class ACBUser {
  ACBUser({
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

  factory ACBUser.fromJson(Map<String, dynamic> json) => ACBUser(
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
