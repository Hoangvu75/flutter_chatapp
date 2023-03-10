class AddProfileResponse {
  bool? success;
  String? message;
  NewProfile? newProfile;

  AddProfileResponse({this.success, this.message, this.newProfile});

  AddProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    newProfile = json['new_profile'] != null
        ? NewProfile.fromJson(json['new_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (newProfile != null) {
      data['new_profile'] = newProfile!.toJson();
    }
    return data;
  }
}

class NewProfile {
  String? accountId;
  String? phone;
  String? name;
  String? birthday;
  String? avatar;
  String? sId;
  int? iV;

  NewProfile(
      {this.accountId,
        this.phone,
        this.name,
        this.birthday,
        this.avatar,
        this.sId,
        this.iV});

  NewProfile.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    phone = json['phone'];
    name = json['name'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['phone'] = phone;
    data['name'] = name;
    data['birthday'] = birthday;
    data['avatar'] = avatar;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
