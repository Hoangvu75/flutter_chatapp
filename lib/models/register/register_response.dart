// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.success,
    this.message,
    this.newAccount,
  });

  bool? success;
  String? message;
  NewAccount? newAccount;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    success: json["success"],
    message: json["message"],
    newAccount: NewAccount.fromJson(json["new_account"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "new_account": newAccount!.toJson(),
  };
}

class NewAccount {
  NewAccount({
    this.username,
    this.password,
    this.id,
    this.v,
  });

  String? username;
  String? password;
  String? id;
  int? v;

  factory NewAccount.fromJson(Map<String, dynamic> json) => NewAccount(
    username: json["username"],
    password: json["password"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "_id": id,
    "__v": v,
  };
}
