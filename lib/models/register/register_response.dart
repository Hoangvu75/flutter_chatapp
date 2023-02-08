class RegisterResponse {
  bool? success;
  String? message;
  NewAccount? newAccount;

  RegisterResponse({this.success, this.message, this.newAccount});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    newAccount = json['new_account'] != null
        ? NewAccount.fromJson(json['new_account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (newAccount != null) {
      data['new_account'] = newAccount!.toJson();
    }
    return data;
  }
}

class NewAccount {
  String? username;
  String? password;
  String? sId;
  int? iV;

  NewAccount({this.username, this.password, this.sId, this.iV});

  NewAccount.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
