import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/viewModels/otpScreenViewModels/otp_screen_viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../utils/app_utils.dart';
import 'otp_screen_body.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final String password;

  const OtpScreen({super.key, required this.phone, required this.password});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: PColors.colorLabelGreen,
            leading: ScaleTap(
              child: SvgPicture.asset(Assets.svgsIcBackCircle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            leadingWidth: 70 * responsiveSize.width,
            title: Text(
              "Enter OTP Code",
              style: TextStyle(fontSize: 18 * responsiveSize.width, fontFamily: Assets.fontsSVNGilroyMedium),
            ),
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => OtpScreenViewModel(),
              )
            ],
            child: OtpScreenBody(
              phone: widget.phone,
              password: widget.password,
            ),
          ),
        ),
      ),
    );
  }
}
