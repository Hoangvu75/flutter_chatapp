import 'package:chatapp/models/login/login_body.dart';
import 'package:flutter/cupertino.dart';

import '../../service/api_service.dart';

class LoginScreenViewModel with ChangeNotifier {
  bool loading = true;

  Future<void> login(String phone, String password) async {
    final loginResponse = await ApiService.create().postLogin(
      LoginBody(username: phone, password: password),
    );
    loading = false;
    notifyListeners();
  }
}
