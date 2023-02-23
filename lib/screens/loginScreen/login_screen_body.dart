import 'package:chatapp/screens/registerScreen/register_screen.dart';
import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/src/gradient_button_loading.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:chatapp/viewModels/loginScreenViewModels/login_screen_viewmodels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


import '../../generated/assets.dart';
import '../../utils/app_functions.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> with TickerProviderStateMixin {
  late LoginScreenViewModel lsvm;

  TextEditingController phoneInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lsvm = Provider.of<LoginScreenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    lsvm = Provider.of<LoginScreenViewModel>(context, listen: true);

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
              "Sign in to your Account",
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
                      controller: phoneInputController,
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
                      controller: passwordInputController,
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
                    height: 36 * responsiveSize.height,
                  ),
                  GradientButtonLoading(
                    title: (lsvm.loading) ? "" : "Sign in",
                    onTap: () {
                      if (phoneInputController.text != "" && passwordInputController.text != "") {
                        lsvm.login(phoneInputController.text, passwordInputController.text);
                      } else {
                        CustomDialog().showDialog(
                          SvgPicture.asset(Assets.svgsIcSystemError),
                          "Oops! You got an error!",
                          "Please fill up your phone and password.",
                          () {},
                          () {},
                        );
                      }
                    },
                    isLoading: lsvm.loading,
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
                    text: "Did You have an Account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16 * responsiveSize.width,
                      fontFamily: Assets.fontsSVNGilroyRegular,
                    ),
                  ),
                  TextSpan(
                    text: "Sign up",
                    style: TextStyle(
                      color: PColors.colorLabelGreen,
                      fontSize: 16 * responsiveSize.width,
                      fontFamily: Assets.fontsSVNGilroyRegular,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        CustomNavigator().pushReplacePrevious(const RegisterScreen());
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
}
