import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';
import '../../viewModels/mainScreenViewModels/main_screen_viewmodels.dart';
import 'main_screen_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
          body: SafeArea(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => MainScreenViewModel(),
                )
              ],
              child: const MainScreenBody(),
            ),
          ),
        ),
      ),
    );
  }
}
