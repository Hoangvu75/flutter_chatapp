import 'dart:async';

import 'package:chatapp/utils/app_functions.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/PColor.dart';
import '../../viewModels/otpScreenViewModels/otp_screen_viewmodels.dart';

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
  OtpTimer? otpTimer;
  final GlobalKey<_OtpTimerState> globalOTPTIMERKey = GlobalKey<_OtpTimerState>();
  bool enableResendOTP = false;

  @override
  void initState() {
    super.initState();
    osvm = Provider.of<OtpScreenViewModel>(context, listen: false);

    osvm.getOtpCode();
    otpTimer = OtpTimer(
      globalOTPTIMERKey,
      () {
        setState(
          () {
            enableResendOTP = true;
          },
        );
      },
    );
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
            autofocus: false,
            controller: otpController,
            hideCharacter: false,
            highlight: true,
            highlightColor: PColors.colorLabelGreen,
            maxLength: 6,
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
          SizedBox(
            height: 30 * responsiveSize.height,
          ),
          resendOtpWidget(),
        ],
      ),
    );
  }

  void onOtpSubmit(String text) {
    if (text == osvm.otpCode) {
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
        otpController.selection = TextSelection.fromPosition(
          const TextPosition(
            offset: 0,
          ),
        );
      });
    }
  }

  Widget resendOtpWidget() {
    return ScaleTap(
      onPressed: (enableResendOTP == true)
          ? () {
              setState(() {
                enableResendOTP = false;
              });
              globalOTPTIMERKey.currentState?.resetTimer();
              osvm.getOtpCode();
            }
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            enableResendOTP == false ? "Didn't receive the OTP code?\nResend OTP code after" : "Resend OTP Code",
            style: TextStyle(
              color: enableResendOTP == false ? Colors.black : PColors.colorLabelGreen,
              fontFamily: enableResendOTP == false ? Assets.fontsSVNGilroyMedium : Assets.fontsSVNGilroySemiBold,
              fontSize: responsiveSize.width * 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10 * responsiveSize.height,
          ),
          if (otpTimer != null) ...[
            Visibility(
              visible: !enableResendOTP,
              child: otpTimer!,
            )
          ]
        ],
      ),
    );
  }
}

class OtpTimer extends StatefulWidget {
  final VoidCallback onTimeOut;

  const OtpTimer(Key? key, this.onTimeOut) : super(key: key);

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 5;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (!mounted) return;
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
          widget.onTimeOut();
        }
      });
    });
  }

  resetTimer() {
    setState(() {
      currentSeconds = 0;
    });
    startTimeout();
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
          width: 5,
        ),
        Text(
          timerText,
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: Assets.fontsSVNGilroyMedium,
            fontSize: responsiveSize.width * 16,
          ),
        )
      ],
    );
  }
}
