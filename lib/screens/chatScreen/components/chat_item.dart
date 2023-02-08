import 'package:chatapp/models/get-chat/get_chat_response.dart';
import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final Chat chat;

  const ChatItem({super.key, required this.chat});

  @override
  State<ChatItem> createState() => _ChatBoxItem();
}

class _ChatBoxItem extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return (widget.chat.sender != phoneNumber)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15 * responsiveSize.width),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5 * responsiveSize.width,
                      blurRadius: 7 * responsiveSize.width,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.grey,
                ),
                padding: EdgeInsets.fromLTRB(15 * responsiveSize.width, 10 * responsiveSize.height,
                    15 * responsiveSize.width, 10 * responsiveSize.height),
                margin: EdgeInsets.all(10 * responsiveSize.width),
                child: Text(
                  widget.chat.content!,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15 * responsiveSize.width),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5 * responsiveSize.width,
                      blurRadius: 7 * responsiveSize.width,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: PColors.colorLabelGreen,
                ),
                padding: EdgeInsets.fromLTRB(15 * responsiveSize.width, 10 * responsiveSize.height,
                    15 * responsiveSize.width, 10 * responsiveSize.height),
                margin: EdgeInsets.all(10 * responsiveSize.width),
                child: Text(
                  widget.chat.content!,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          );
  }
}
