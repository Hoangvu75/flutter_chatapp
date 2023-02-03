// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.success,
    this.message,
    this.token,
    this.account,
  });

  bool? success;
  String? message;
  String? token;
  Account? account;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    account: Account.fromJson(json["account"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "account": account!.toJson(),
  };
}

class Account {
  Account({
    this.id,
    this.username,
    this.password,
    this.v,
  });

  String? id;
  String? username;
  String? password;
  int? v;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["_id"],
    username: json["username"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "password": password,
    "__v": v,
  };
}
