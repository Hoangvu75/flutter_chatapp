// To parse this JSON data, do
//
//     final loginBody = loginBodyFromJson(jsonString);

import 'dart:convert';

SearchPhoneBody loginBodyFromJson(String str) => SearchPhoneBody.fromJson(json.decode(str));

String loginBodyToJson(SearchPhoneBody data) => json.encode(data.toJson());

class SearchPhoneBody {
  SearchPhoneBody({
    required this.phone,
  });

  String phone;

  factory SearchPhoneBody.fromJson(Map<String, dynamic> json) => SearchPhoneBody(
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}
