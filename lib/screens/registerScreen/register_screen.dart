import 'package:chatapp/screens/registerScreen/register_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        child: const Scaffold(
          body: RegisterScreenBody(),
        ),
      ),
    );
  }
}
