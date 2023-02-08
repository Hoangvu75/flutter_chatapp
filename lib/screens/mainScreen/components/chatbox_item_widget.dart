import 'package:chatapp/generated/assets.dart';
import 'package:chatapp/models/get-chatbox-list/get_chatbox_list_response.dart';
import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ChatBoxItem extends StatefulWidget {
  final List<Chat> chatList;
  final List<GCLRUser> userList;

  const ChatBoxItem({super.key, required this.chatList, required this.userList});

  @override
  State<ChatBoxItem> createState() => _ChatBoxItem();
}

class _ChatBoxItem extends State<ChatBoxItem> {
  late GCLRUser self;
  late GCLRUser friend;

  late String lastMessage;
  late String time;

  @override
  void initState() {
    super.initState();

    if (widget.userList[0].phone! == phoneNumber) {
      self = widget.userList[0];
      friend = widget.userList[1];
    } else {
      self = widget.userList[1];
      friend = widget.userList[0];
    }

    if (widget.chatList.isNotEmpty) {
      lastMessage = widget.chatList.last.content!;
      time = widget.chatList.last.time!;
    } else {
      lastMessage = "";
      time = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15 * responsiveSize.width),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
              0 * responsiveSize.width,
              0,
              0,
              20 * responsiveSize.width,
            ),
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              2 * responsiveSize.width,
              0,
            ),
            width: MediaQuery.of(context).size.width,
            height: 85 * responsiveSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50 * responsiveSize.width),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 18 * responsiveSize.width, 0),
                  width: 60 * responsiveSize.width,
                  height: 60 * responsiveSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(60 * responsiveSize.width),
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
                    borderRadius: BorderRadius.circular(50 * responsiveSize.width),
                    child: (friend.avatar != "")
                        ? Image.network(
                            friend.avatar!,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(Assets.svgsAvatarDefault),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      21.5 * responsiveSize.width,
                      0,
                      14 * responsiveSize.width,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            1 * responsiveSize.width,
                            0,
                            0,
                            6.5 * responsiveSize.width,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: friend.name,
                                    style: TextStyle(
                                      fontFamily: Assets.fontsSVNGilroyBold,
                                      fontSize: 18 * responsiveSize.width,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 1 * responsiveSize.width, 0, 0),
                                child: Text(
                                  (time != "")
                                      ? DateFormat('Hm')
                                          .format(DateTime.fromMillisecondsSinceEpoch(int.parse(time)))
                                      : "",
                                  style: TextStyle(
                                    fontFamily: Assets.fontsSVNGilroyRegular,
                                    fontSize: 12 * responsiveSize.width,
                                    fontStyle: FontStyle.italic,
                                    color: PColors.lightColorText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          (widget.chatList.isNotEmpty)
                          ? (self.phone != widget.chatList.last.sender) ? "${friend.name}: "
                              "$lastMessage" : "You: $lastMessage"
                          : "",
                          style: TextStyle(fontSize: 12 * responsiveSize.width, color: PColors.lightColorText),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1 * responsiveSize.width,
          ),
        ],
      ),
    );
  }
}
