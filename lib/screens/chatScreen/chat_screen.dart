import 'package:chatapp/models/get-chatbox-list/get_chatbox_list_response.dart';
import 'package:chatapp/screens/chatScreen/chat_screen_body.dart';
import 'package:chatapp/viewModels/chatScreenViewModels/scroll_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';
import '../../viewModels/chatScreenViewModels/chat_screen_viewmodels.dart';

class ChatScreen extends StatefulWidget {
  final List<GCLRUser> userList;
  const ChatScreen({super.key, required this.userList});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ChatScreenViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => ScrollControllerProvider(),
              )
            ],
            child: ChatScreenBody(userList: widget.userList,),
          ),
        ),
      ),
    );
  }
}
