import 'package:chatapp/models/profile/add_profile_body.dart';
import 'package:chatapp/screens/loginScreen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../../models/login/login_body.dart';
import '../../service/api_service.dart';
import '../../utils/app_functions.dart';

class GetInfoScreenViewModel with ChangeNotifier {
  bool loading = false;
  String saveBtnState = "Save";

  Future<void> getInfo(String phone, String password, String name, String birthday, String avatar) async {
    saveBtnState = "";
    loading = true;
    notifyListeners();

    final loginResponse = await ApiService.create().postLogin(
      LoginBody(username: phone, password: password),
    );

    var addProfileResponse = await ApiService.createWithAuthorization(
      loginResponse.token.toString(),
    ).postAddProfile(
      AddProfileBody(phone: phone, name: name, birthday: birthday, avatar: avatar),
    );

    saveBtnState = "Finish";
    loading = false;
    CustomDialog().showDialog(
      SvgPicture.asset(Assets.svgsIcSuccess),
      "Everything is done!",
      "Start your journey now!",
      () {
        CustomNavigator().pushReplacePrevious(const LoginScreen());
      },
      () {
        CustomNavigator().pushReplacePrevious(const LoginScreen());
      },
    );
    notifyListeners();
  }
}
