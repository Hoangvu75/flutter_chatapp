import 'package:chatapp/screens/loginScreen/login_screen.dart';
import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/src/gradient_button.dart';
import 'package:chatapp/utils/app_functions.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../otpScreen/opt_screen.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> with TickerProviderStateMixin {
  late TextEditingController phoneFieldController = TextEditingController();
  late TextEditingController passwordFieldController = TextEditingController();
  late TextEditingController rePasswordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    phoneFieldController.text = "0941290613";
    passwordFieldController.text = "0941290613";
    rePasswordFieldController.text = "0941290613";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 128 * responsiveSize.height),
              child: Image.asset(Assets.imgLabelChatlify),
            ),
            SizedBox(
              height: 64 * responsiveSize.height,
            ),
            Text(
              "Sign up for free",
              style: TextStyle(
                fontFamily: Assets.fontsSVNGilroyMedium,
                fontSize: 26 * responsiveSize.width,
              ),
            ),
            SizedBox(
              height: 48 * responsiveSize.height,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 32 * responsiveSize.width,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 332 * responsiveSize.width,
                    height: 50 * responsiveSize.height,
                    decoration: BoxDecoration(
                      color: PColors.colorTextField,
                      borderRadius: BorderRadius.circular(100 * responsiveSize.width),
                    ),
                    child: TextField(
                      controller: phoneFieldController,
                      cursorColor: PColors.colorLabelGreen,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 14 * responsiveSize.width,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          20 * responsiveSize.width,
                          15 * responsiveSize.width,
                          20 * responsiveSize.width,
                          15 * responsiveSize.width,
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                        hintText: "Enter Your Phone number",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 32 * responsiveSize.width,
                          ),
                          borderRadius: BorderRadius.circular(
                            25 * responsiveSize.width,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 32 * responsiveSize.width,
                          ),
                          borderRadius: BorderRadius.circular(
                            25 * responsiveSize.width,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10 * responsiveSize.height,
                  ),
                  Container(
                    width: 332 * responsiveSize.width,
                    height: 50 * responsiveSize.height,
                    decoration: BoxDecoration(
                      color: PColors.colorTextField,
                      borderRadius: BorderRadius.circular(100 * responsiveSize.width),
                    ),
                    child: TextField(
                      controller: passwordFieldController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 14 * responsiveSize.width,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          20 * responsiveSize.width,
                          15 * responsiveSize.width,
                          20 * responsiveSize.width,
                          15 * responsiveSize.width,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        hintText: "Enter Your Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 32 * responsiveSize.width,
                          ),
                          borderRadius: BorderRadius.circular(
                            25 * responsiveSize.width,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 32 * responsiveSize.width,
                          ),
                          borderRadius: BorderRadius.circular(
                            25 * responsiveSize.width,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10 * responsiveSize.height,
                  ),
                  Container(
                    width: 332 * responsiveSize.width,
                    height: 50 * responsiveSize.height,
                    decoration: BoxDecoration(
                      color: PColors.colorTextField,
                      borderRadius: BorderRadius.circular(100 * responsiveSize.width),
                    ),
                    child: TextField(
                      controller: rePasswordFieldController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 14 * responsiveSize.width,
                        fontFamily: Assets.fontsSVNGilroyRegular,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          20 * responsiveSize.width,
                          15 * responsiveSize.width,
                          20 * responsiveSize.width,
                          15 * responsiveSize.width,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        hintText: "Re-enter Your Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 32 * responsiveSize.width,
                          ),
                          borderRadius: BorderRadius.circular(
                            25 * responsiveSize.width,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 32 * responsiveSize.width,
                          ),
                          borderRadius: BorderRadius.circular(
                            25 * responsiveSize.width,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36 * responsiveSize.height,
                  ),
                  GradientButton(
                    title: "Sign up",
                    onTap: () => onSignUpSubmit(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24 * responsiveSize.height,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an Account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16 * responsiveSize.width,
                      fontFamily: Assets.fontsSVNGilroyRegular,
                    ),
                  ),
                  TextSpan(
                    text: "Sign in",
                    style: TextStyle(
                      color: PColors.colorLabelGreen,
                      fontSize: 16 * responsiveSize.width,
                      fontFamily: Assets.fontsSVNGilroyRegular,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        CustomNavigator().pushReplacePrevious(const LoginScreen());
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validatePhoneNumber(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (value.length != 10) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  void onSignUpSubmit() {
    if (validatePhoneNumber(phoneFieldController.text) == false) {
      var errorDialog = CustomDialog();
      errorDialog.showDialog(
        SvgPicture.asset(Assets.svgsIcSystemError),
        "Register Error",
        "Invalid phone number format",
        () => {},
        () => {},
      );
    } else if (passwordFieldController.text.length < 8) {
      var errorDialog = CustomDialog();
      errorDialog.showDialog(
        SvgPicture.asset(Assets.svgsIcSystemError),
        "Register Error",
        "Password length must be more than 8 digits",
        () => {},
        () => {},
      );
    } else if (passwordFieldController.text != rePasswordFieldController.text) {
      CustomDialog().showDialog(
        SvgPicture.asset(Assets.svgsIcSystemError),
        "Register Error",
        "Please enter correct password",
        () => {},
        () => {},
      );
    } else {
      CustomNavigator().pushNewScreen(
        OtpScreen(
          phone: phoneFieldController.text,
          password: passwordFieldController.text,
        ),
      );
    }
  }
}
