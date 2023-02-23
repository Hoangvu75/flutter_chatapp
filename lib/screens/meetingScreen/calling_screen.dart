import 'package:chatapp/src/PColor.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../generated/assets.dart';
import '../../models/get-chatbox-list/get_chatbox_list_response.dart';
import 'api.dart';
import 'meeting_screen.dart';

class CallingScreen extends StatefulWidget {
  final GCLRUser friend;
  final String meetingId;

  const CallingScreen({super.key, required this.friend, required this.meetingId});

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150 * responsiveSize.width,
                height: 150 * responsiveSize.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(250 * responsiveSize.width),
                  child: (widget.friend.avatar == "")
                      ? SvgPicture.asset(Assets.svgsAvatarDefault)
                      : Image.network(
                          widget.friend.avatar!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                height: 20 * responsiveSize.height,
              ),
              Text(
                widget.friend.name!,
                style: TextStyle(fontSize: 26 * responsiveSize.width, fontFamily: Assets.fontsSVNGilroyRegular),
              ),
              SizedBox(
                height: 50 * responsiveSize.height,
              ),
              Text(
                "Calling",
                style: TextStyle(
                    fontSize: 18 * responsiveSize.width,
                    fontFamily: Assets.fontsSVNGilroyRegular,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50 * responsiveSize.height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTap(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 250),
                          child: MeetingScreen(
                            meetingId: widget.meetingId,
                            token: token,
                            leaveMeeting: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 255, 204, 1.0),
                        borderRadius: BorderRadius.circular(50 * responsiveSize.width)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.phone,
                          size: 30 * responsiveSize.width,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50 * responsiveSize.width,
                  ),
                  ScaleTap(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 0, 0, 1.0),
                          borderRadius: BorderRadius.circular(50 * responsiveSize.width)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.phone_disabled,
                          size: 30 * responsiveSize.width,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
