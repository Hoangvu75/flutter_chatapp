import 'package:chatapp/utils/app_functions.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/PColor.dart';
import '../../viewModels/otpScreenViewModels/otp_screen_viewmodels.dart';
import '../getInfoScreen/get_info_screen.dart';

class OtpScreenBody extends StatefulWidget {
  final String phone;
  final String password;

  const OtpScreenBody({super.key, required this.phone, required this.password});

  @override
  State<OtpScreenBody> createState() => _OtpScreenBodyState();
}

class _OtpScreenBodyState extends State<OtpScreenBody> with TickerProviderStateMixin {
  late OtpScreenViewModel osvm;

  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    osvm = Provider.of<OtpScreenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    osvm = Provider.of<OtpScreenViewModel>(context, listen: true);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18 * responsiveSize.width,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50 * responsiveSize.height,
          ),
          Text(
            "An OTP Code has been sent to your phone number. Please enter OTP Code to continue.",
            style: TextStyle(
              fontSize: 16 * responsiveSize.width,
              fontFamily: Assets.fontsSVNGilroyMedium,
            ),
          ),
          SizedBox(
            height: 50 * responsiveSize.height,
          ),
          PinCodeTextField(
            autofocus: true,
            controller: otpController,
            hideCharacter: false,
            highlight: true,
            highlightColor: PColors.colorLabelGreen,
            maxLength: 4,
            maskCharacter: "•",
            pinBoxRadius: 10,
            onTextChanged: (text) {},
            onDone: (text) {
              onOtpSubmit(text);
            },
            pinBoxWidth: MediaQuery.of(context).size.height * 0.06,
            pinBoxHeight: MediaQuery.of(context).size.height * 0.065,
            hasUnderline: false,
            wrapAlignment: WrapAlignment.spaceAround,
            pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
            pinBoxBorderWidth: 1.0,
            pinBoxColor: Colors.white,
            pinTextStyle: TextStyle(fontSize: responsiveSize.width * 24, fontFamily: Assets.fontsSVNGilroyMedium),
            pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
            pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
            highlightAnimation: false,
            highlightPinBoxColor: Colors.white,
            highlightAnimationBeginColor: Colors.white,
            highlightAnimationEndColor: Colors.white,
            keyboardType: TextInputType.number,
            pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 2),
          ),
        ],
      ),
    );
  }

  void onOtpSubmit(String text) {
    if (text == "1234") {
      EasyLoading.show(status: "loading...");
      osvm.register(widget.phone, widget.password);
    } else {
      CustomDialog().showDialog(
        SvgPicture.asset(Assets.svgsIcSystemError),
        "Oops! You've got an error!",
        "Invalid OTP Code, please try again.",
        () {},
        () {},
      );
      setState(() {
        otpController.text = "";
      });
    }
  }
}
