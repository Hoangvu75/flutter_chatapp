import 'package:chatapp/models/profile/add_profile_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/login/login_body.dart';
import '../../service/api_service.dart';

class GetInfoScreenViewModel with ChangeNotifier {
  bool loading = false;
  String saveBtnState = "Save";

  Future<void> getInfo(String phone, String password, String name, String birthday, String avatar) async {
    loading = true;
    saveBtnState = "";
    notifyListeners();

    final loginResponse = await ApiService.create().postLogin(
      LoginBody(username: phone, password: password),
    );

    var addProfileResponse = await ApiService.createWithAuthorization(
      loginResponse.token.toString(),
    ).postAddProfile(
      AddProfileBody(name: name, birthday: birthday, avatar: avatar),
    );

    saveBtnState = "Finish";
    loading = false;
    notifyListeners();
  }
}
