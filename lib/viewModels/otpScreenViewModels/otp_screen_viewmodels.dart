import 'package:chatapp/models/register/register_body.dart';
import 'package:chatapp/screens/getInfoScreen/get_info_screen.dart';
import 'package:chatapp/utils/app_functions.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../generated/assets.dart';
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

  late String otpCode;
  Future<void> getOtpCode() async {
    var otpResponse = await ApiService.create().getGenerateOTP();
    otpCode = otpResponse.otpCode!;
    showToast(
      otpCode,
      context: AppUtils.currentContext,
      position: StyledToastPosition(
        align: Alignment.bottomCenter,
        offset: 350 * responsiveSize.height,
      ),
      backgroundColor: Colors.redAccent,
      textPadding: EdgeInsets.symmetric(
        vertical: 20 * responsiveSize.height,
        horizontal: 50 * responsiveSize.width,
      ),
      textStyle: TextStyle(
        fontSize: 20 * responsiveSize.width,
        color: Colors.white,
        fontFamily: Assets.fontsSVNGilroySemiBold,
      ),
      alignment: Alignment.topCenter,
      borderRadius: BorderRadius.circular(10 * responsiveSize.width),
      duration: const Duration(seconds: 4),
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.rotate,
      animDuration: const Duration(seconds: 1),
    );
  }
}
