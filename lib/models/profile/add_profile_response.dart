// To parse this JSON data, do
//
//     final addProfileResponse = addProfileResponseFromJson(jsonString);

import 'dart:convert';

AddProfileResponse addProfileResponseFromJson(String str) => AddProfileResponse.fromJson(json.decode(str));

String addProfileResponseToJson(AddProfileResponse data) => json.encode(data.toJson());

class AddProfileResponse {
  AddProfileResponse({
    this.success,
    this.message,
    this.newProfile,
  });

  bool? success;
  String? message;
  NewProfile? newProfile;

  factory AddProfileResponse.fromJson(Map<String, dynamic> json) => AddProfileResponse(
    success: json["success"],
    message: json["message"],
    newProfile: NewProfile.fromJson(json["new_profile"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "new_profile": newProfile!.toJson(),
  };
}

class NewProfile {
  NewProfile({
    this.accountId,
    this.name,
    this.birthday,
    this.avatar,
    this.id,
    this.v,
  });

  String? accountId;
  String? name;
  String? birthday;
  String? avatar;
  String? id;
  int? v;

  factory NewProfile.fromJson(Map<String, dynamic> json) => NewProfile(
    accountId: json["account_id"],
    name: json["name"],
    birthday: json["birthday"],
    avatar: json["avatar"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "name": name,
    "birthday": birthday,
    "avatar": avatar,
    "_id": id,
    "__v": v,
  };
}
