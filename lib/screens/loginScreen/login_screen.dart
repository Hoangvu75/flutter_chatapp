import 'package:chatapp/viewModels/loginScreenViewModels/login_screen_viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';
import 'login_screen_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => LoginScreenViewModel(),
            )
          ],
          child: const LoginScreenBody(),
        ),
      ),
    );
  }
}
