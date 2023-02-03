import 'package:chatapp/models/register/register_body.dart';
import 'package:chatapp/screens/getInfoScreen/get_info_screen.dart';
import 'package:chatapp/utils/app_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/otpScreen/opt_screen.dart';
import '../../service/api_service.dart';

class OtpScreenViewModel with ChangeNotifier {
  bool loading = false;

  Future<void> register(String phone, String password) async {
    loading = true;
    notifyListeners();
    var registerResponse = await ApiService.createWithErrorHandler(
      () {
        loading = false;
        notifyListeners();
      },
      () {
        loading = false;
        notifyListeners();
      },
      "This account has been created",
    ).postRegister(
      RegisterBody(username: phone, password: password),
    );

    if (registerResponse.success == true) {
      CustomNavigator().pushReplacePrevious(
        GetInfoScreen(
          phone: registerResponse.newAccount!.username.toString(),
          password: registerResponse.newAccount!.password.toString(),
        ),
      );
    }
  }
}
