import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleWebcamButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls({
    Key? key,
    required this.onToggleMicButtonPressed,
    required this.onToggleWebcamButtonPressed,
    required this.onLeaveButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ScaleTap(
          onPressed: onLeaveButtonPressed,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.circular(50 * responsiveSize.width)
            ),
            child: Padding(
              padding: EdgeInsets.all(5 * responsiveSize.width),
              child: Icon(
                Icons.exit_to_app,
                size: 30 * responsiveSize.width,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10 * responsiveSize.height,
        ),
        ScaleTap(
          onPressed: onToggleMicButtonPressed,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(50 * responsiveSize.width)
            ),
            child: Padding(
              padding: EdgeInsets.all(5 * responsiveSize.width),
              child: Icon(
                Icons.mic,
                size: 30 * responsiveSize.width,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10 * responsiveSize.height,
        ),
        ScaleTap(
          onPressed: onToggleWebcamButtonPressed,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(50 * responsiveSize.width)
            ),
            child: Padding(
              padding: EdgeInsets.all(5 * responsiveSize.width),
              child: Icon(
                Icons.camera_indoor,
                size: 30 * responsiveSize.width,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
