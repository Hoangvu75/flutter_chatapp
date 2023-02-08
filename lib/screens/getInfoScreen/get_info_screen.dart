import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../src/PColor.dart';
import '../../utils/app_utils.dart';
import '../../viewModels/getInfoScreenViewModels/get_info_screen_viewmodels.dart';
import 'get_info_screen_body.dart';

class GetInfoScreen extends StatefulWidget {
  final String phone;
  final String password;

  const GetInfoScreen({super.key, required this.phone, required this.password});

  @override
  State<GetInfoScreen> createState() => _GetInfoScreenState();
}

class _GetInfoScreenState extends State<GetInfoScreen> {
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
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Fill your information",
                style: TextStyle(
                  fontSize: 18 * responsiveSize.width,
                  fontFamily: Assets.fontsSVNGilroyMedium,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => GetInfoScreenViewModel(),
              )
            ],
            child: GetInfoScreenBody(
              phone: widget.phone,
              password: widget.password,
            ),
          ),
        ),
      ),
    );
  }
}
