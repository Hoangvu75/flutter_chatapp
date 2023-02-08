import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../src/PColor.dart';

class FakeChatItem extends StatefulWidget {
  final int type;
  final String chat;

  const FakeChatItem({super.key, required this.chat, required this.type});

  @override
  State<FakeChatItem> createState() => _FakeChatItem();
}

class _FakeChatItem extends State<FakeChatItem> {
  @override
  Widget build(BuildContext context) {
    return (widget.type == 1)
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
                  widget.chat,
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
                  widget.chat,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          );
  }
}
