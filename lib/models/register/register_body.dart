// To parse this JSON data, do
//
//     final registerBody = registerBodyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterBody registerBodyFromJson(String str) => RegisterBody.fromJson(json.decode(str));

String registerBodyToJson(RegisterBody data) => json.encode(data.toJson());

class RegisterBody {
  RegisterBody({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory RegisterBody.fromJson(Map<String, dynamic> json) => RegisterBody(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
