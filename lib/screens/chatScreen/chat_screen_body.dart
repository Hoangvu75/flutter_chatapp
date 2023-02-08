import 'package:chatapp/models/get-chat/get_chat_body.dart';
import 'package:chatapp/models/get-chatbox-list/get_chatbox_list_response.dart';
import 'package:chatapp/screens/chatScreen/components/chat_item.dart';
import 'package:chatapp/screens/mainScreen/main_screen.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:chatapp/viewModels/chatScreenViewModels/chat_screen_viewmodels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

import '../../generated/assets.dart';
import '../../models/add-chat/add_chat_body.dart';
import '../../src/PColor.dart';
import '../../utils/app_functions.dart';
import '../../viewModels/chatScreenViewModels/scroll_controller_provider.dart';

class ChatScreenBody extends StatefulWidget {
  final List<GCLRUser> userList;

  const ChatScreenBody({super.key, required this.userList});

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> with TickerProviderStateMixin {
  late ChatScreenViewModel csvm;
  late ScrollControllerProvider scp;

  late GCLRUser self;
  late GCLRUser friend;

  late io.Socket socket;

  late TextEditingController textEditingController;

  @override
  void initState() {
    csvm = Provider.of<ChatScreenViewModel>(context, listen: false);
    scp = Provider.of<ScrollControllerProvider>(context, listen: false);

    csvm.onGetChatResponse(
      GCBUser(
        accountId: widget.userList[0].accountId!,
        phone: widget.userList[0].phone!,
        name: widget.userList[0].name!,
        birthday: widget.userList[0].birthday!,
        avatar: widget.userList[0].avatar!,
        id: widget.userList[0].sId!,
      ),
      GCBUser(
        accountId: widget.userList[1].accountId!,
        phone: widget.userList[1].phone!,
        name: widget.userList[1].name!,
        birthday: widget.userList[1].birthday!,
        avatar: widget.userList[1].avatar!,
        id: widget.userList[1].sId!,
      ),
    );
    scp.createScrollControlListener();

    if (widget.userList[0].phone! == phoneNumber) {
      self = widget.userList[0];
      friend = widget.userList[1];
    } else {
      self = widget.userList[1];
      friend = widget.userList[0];
    }

    initSocket();

    textEditingController = TextEditingController();

    super.initState();
  }

  void initSocket() {
    // socket = IO.io('http://192.168.1.4:3000', OptionBuilder().setTransports(['websocket']).build());
    socket = io.io('https://chatapp-server-production-95e0.up.railway.app',
        OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      if (kDebugMode) {
        print('socket connected');
      }
    });

    socket.on('chat response', (data) {
      if (kDebugMode) {
        print(data);
      }
      csvm.onAddFakeChat(data, 1);
      scp.jumpToMaxPosition();
    });

    socket.onDisconnect((_) {
      if (kDebugMode) {
        print('disconnect');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      scp.jumpToMaxPosition();
    });
  }

  @override
  void dispose() {
    csvm.dispose();
    scp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    csvm = Provider.of<ChatScreenViewModel>(context, listen: true);
    scp = Provider.of<ScrollControllerProvider>(context, listen: true);

    return Column(
      children: [
        SizedBox(
          height: AppBar().preferredSize.height,
        ),
        SizedBox(
          height: 20 * responsiveSize.height,
        ),
        Row(
          children: [
            SizedBox(
              width: 10 * responsiveSize.width,
            ),
            ScaleTap(
              onPressed: () => CustomNavigator().pushReplacePrevious(
                const MainScreen(),
              ),
              child: Icon(
                Icons.arrow_back,
                color: PColors.colorLabelGreen,
                size: 35 * responsiveSize.width,
              ),
            ),
            SizedBox(
              width: 10 * responsiveSize.width,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 18 * responsiveSize.width, 0),
              width: 40 * responsiveSize.width,
              height: 40 * responsiveSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(40 * responsiveSize.width),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5 * responsiveSize.width,
                    blurRadius: 7 * responsiveSize.width,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40 * responsiveSize.width),
                child: (friend.avatar == "")
                    ? SvgPicture.asset(Assets.svgsAvatarDefault)
                    : Image.network(friend.avatar!),
              ),
            ),
            Expanded(
              child: Text(
                friend.name!,
                style: TextStyle(fontSize: 18 * responsiveSize.width, fontFamily: Assets.fontsSVNGilroySemiBold),
              ),
            ),
            ScaleTap(
              onPressed: () {},
              child: Container(
                width: 45 * responsiveSize.width,
                height: 45 * responsiveSize.height,
                decoration: BoxDecoration(
                    color: PColors.lightGreen2, borderRadius: BorderRadius.circular(5 * responsiveSize.width)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    7 * responsiveSize.width,
                    7 * responsiveSize.height,
                    7 * responsiveSize.width,
                    7 * responsiveSize.height,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: PColors.lightGreen, borderRadius: BorderRadius.circular(5 * responsiveSize.width)),
                    child: Icon(
                      Icons.video_call_sharp,
                      size: 25 * responsiveSize.width,
                      color: PColors.gradientButtonEnd,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10 * responsiveSize.width,
            ),
            ScaleTap(
              onPressed: () async {
                var platform = const MethodChannel("MY_CHANNEL");
                await platform.invokeMethod("navToVideoCall");
              },
              child: Container(
                width: 45 * responsiveSize.width,
                height: 45 * responsiveSize.height,
                decoration: BoxDecoration(
                    color: PColors.lightGreen2, borderRadius: BorderRadius.circular(5 * responsiveSize.width)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    7 * responsiveSize.width,
                    7 * responsiveSize.height,
                    7 * responsiveSize.width,
                    7 * responsiveSize.height,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: PColors.lightGreen, borderRadius: BorderRadius.circular(5 * responsiveSize.width)),
                    child: Icon(
                      Icons.call,
                      size: 25 * responsiveSize.width,
                      color: PColors.gradientButtonEnd,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20 * responsiveSize.width,
            ),
          ],
        ),
        SizedBox(
          height: 20 * responsiveSize.height,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1 * responsiveSize.height,
          color: PColors.lightColorText,
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: scp.bodyScrollController,
            child: (csvm.chatList != [])
                ? Column(
                    children: [
                      for (var i = 0; i < csvm.chatList.length; i++)
                        ChatItem(
                          chat: csvm.chatList[i],
                        ),
                      for (var j = 0; j < csvm.fakeChatList.length; j++) csvm.fakeChatList[j]
                    ],
                  )
                : Container(),
          ),
        ),
        TextFormField(
          controller: textEditingController,
          onFieldSubmitted: (value) {
            socket.emit("chat request", (value));
            csvm.onAddFakeChat(value, 0);
            csvm.onAddChat(
              ACBUser(
                accountId: widget.userList[0].accountId!,
                phone: widget.userList[0].phone!,
                name: widget.userList[0].name!,
                birthday: widget.userList[0].birthday!,
                avatar: widget.userList[0].avatar!,
                id: widget.userList[0].sId!,
              ),
              ACBUser(
                accountId: widget.userList[1].accountId!,
                phone: widget.userList[1].phone!,
                name: widget.userList[1].name!,
                birthday: widget.userList[1].birthday!,
                avatar: widget.userList[1].avatar!,
                id: widget.userList[1].sId!,
              ),
              value,
            );
            scp.jumpToMaxPosition();
            textEditingController.clear();
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.tag_faces_sharp),
            hintText: 'message',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
