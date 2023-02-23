import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'join_screen.dart';
import 'meeting_screen.dart';

class VideoSdkScreen extends StatefulWidget {
  const VideoSdkScreen({Key? key}) : super(key: key);

  @override
  State<VideoSdkScreen> createState() => _VideoSdkScreenState();
}

class _VideoSdkScreenState extends State<VideoSdkScreen> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VideoSDK QuickStart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMeetingActive
            ? MeetingScreen(
          meetingId: meetingId,
          token: token,
          leaveMeeting: () {
            setState(() => isMeetingActive = false);
          },
        )
            : JoinScreen(
          onMeetingIdChanged: (value) => meetingId = value,
          onCreateMeetingButtonPressed: () async {
            meetingId = await createMeeting();
            setState(() => isMeetingActive = true);
            print("meeting id: $meetingId");
          },
          onJoinMeetingButtonPressed: () {
            setState(() => isMeetingActive = true);
          },
        ),
      ),
    );
  }
}

