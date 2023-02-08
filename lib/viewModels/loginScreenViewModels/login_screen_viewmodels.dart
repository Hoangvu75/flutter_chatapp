import 'package:chatapp/models/login/login_body.dart';
import 'package:chatapp/screens/mainScreen/main_screen.dart';
import 'package:chatapp/utils/app_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../../service/api_service.dart';
import '../../utils/app_utils.dart';

class LoginScreenViewModel with ChangeNotifier {
  bool loading = false;

  Future<void> login(String phone, String password) async {
    loading = true;
    notifyListeners();

    try {
      var loginResponse = await ApiService.create().postLogin(
        LoginBody(username: phone, password: password),
      );

      if (loginResponse.success == false) {
        CustomDialog().showDialog(
          SvgPicture.asset(Assets.svgsIcSystemError),
          "Login error!",
          loginResponse.message!,
          () {},
          () {},
        );
      }

      if (loginResponse.success == true) {
        phoneNumber = loginResponse.account!.username!;
        accessToken = loginResponse.token!;
        CustomNavigator().pushReplacePrevious(
          const MainScreen(),
        );
      }
    } on Exception catch (e) {
      print(e);
    }

    loading = false;
    notifyListeners();
  }
}
