// To parse this JSON data, do
//
//     final getChatboxListBody = getChatboxListBodyFromJson(jsonString);

import 'dart:convert';

GetChatboxListBody getChatboxListBodyFromJson(String str) => GetChatboxListBody.fromJson(json.decode(str));

String getChatboxListBodyToJson(GetChatboxListBody data) => json.encode(data.toJson());

class GetChatboxListBody {
  GetChatboxListBody({
    required this.phone,
  });

  String phone;

  factory GetChatboxListBody.fromJson(Map<String, dynamic> json) => GetChatboxListBody(
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}
