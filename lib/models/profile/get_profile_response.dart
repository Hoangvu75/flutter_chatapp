class GetProfileResponse {
  bool? success;
  Profile? profile;

  GetProfileResponse({this.success, this.profile});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? sId;
  String? accountId;
  String? phone;
  String? name;
  String? birthday;
  String? avatar;
  int? iV;

  Profile(
      {this.sId,
        this.accountId,
        this.phone,
        this.name,
        this.birthday,
        this.avatar,
        this.iV});

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountId = json['account_id'];
    phone = json['phone'];
    name = json['name'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['account_id'] = accountId;
    data['phone'] = phone;
    data['name'] = name;
    data['birthday'] = birthday;
    data['avatar'] = avatar;
    data['__v'] = iV;
    return data;
  }
}
