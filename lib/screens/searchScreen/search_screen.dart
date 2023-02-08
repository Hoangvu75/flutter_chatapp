import 'package:chatapp/screens/searchScreen/search_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';
import '../../viewModels/mainScreenViewModels/main_screen_viewmodels.dart';
import '../../viewModels/searchScreenViewModels/search_screen_viewmodels.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SearchScreenViewModel(),
            )
          ],
          child: const SearchScreenBody(),
        ),
      ),
    );
  }
}
