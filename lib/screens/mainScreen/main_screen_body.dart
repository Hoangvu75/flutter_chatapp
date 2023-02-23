import 'package:chatapp/generated/assets.dart';
import 'package:chatapp/screens/mainScreen/components/chatbox_item_widget.dart';
import 'package:chatapp/screens/searchScreen/search_screen.dart';
import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/utils/app_functions.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:chatapp/viewModels/mainScreenViewModels/main_screen_viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:provider/provider.dart';

import '../chatScreen/chat_screen.dart';

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({super.key});

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> with TickerProviderStateMixin {
  late MainScreenViewModel msvm;

  int _selector = 1;

  @override
  void initState() {
    msvm = Provider.of<MainScreenViewModel>(context, listen: false);
    msvm.getChatBoxList();

    super.initState();
  }

  @override
  void dispose() {
    msvm.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    msvm = Provider.of<MainScreenViewModel>(context);

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * responsiveSize.width),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Chatify",
                      style: TextStyle(fontSize: 28 * responsiveSize.width, fontFamily: Assets.fontsSVNGilroyBold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () => CustomNavigator().pushNewScreen(
                      const SearchScreen(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10 * responsiveSize.height,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * responsiveSize.width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ScaleTap(
                    onPressed: () => setState(() => _selector = 1),
                    child: Container(
                      decoration: (_selector == 1)
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: PColors.gradientButtonStart,
                                  width: 2 * responsiveSize.width,
                                ),
                              ),
                            )
                          : null,
                      child: Padding(
                        padding: EdgeInsets.all(8 * responsiveSize.width),
                        child: Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 20 * responsiveSize.width,
                              fontFamily: Assets.fontsSVNGilroySemiBold,
                              color: (_selector == 1) ? PColors.gradientButtonStart : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ScaleTap(
                    onPressed: () => setState(() => _selector = 2),
                    child: Container(
                      decoration: (_selector == 2)
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: PColors.gradientButtonStart,
                                  width: 2 * responsiveSize.width,
                                ),
                              ),
                            )
                          : null,
                      child: Padding(
                        padding: EdgeInsets.all(8 * responsiveSize.width),
                        child: Text(
                          "Calls",
                          style: TextStyle(
                              fontSize: 20 * responsiveSize.width,
                              fontFamily: Assets.fontsSVNGilroySemiBold,
                              color: (_selector == 2) ? PColors.gradientButtonStart : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20 * responsiveSize.height,
            ),
            (_selector == 1)
                ? Column(
                    children: [
                      for (var i = 0; i < msvm.chatboxList.length; i++)
                        ChatBoxItem(
                          chatList: msvm.chatboxList[i].chat!,
                          userList: msvm.chatboxList[i].user!,
                        ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
