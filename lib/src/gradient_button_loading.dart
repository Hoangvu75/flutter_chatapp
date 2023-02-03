import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import '../generated/assets.dart';
import 'PColor.dart';

class GradientButtonLoading extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Function() onTap;

  const GradientButtonLoading({
    super.key,
    required this.title,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ScaleTap(
        onPressed: () {},
        enableFeedback: false,
        child: Container(
          height: 60 * responsiveSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                PColors.gradientButtonStart,
                PColors.gradientButtonEnd,
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: Assets.fontsSVNGilroySemiBold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return ScaleTap(
        onPressed: onTap,
        child: Container(
          height: 60 * responsiveSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                PColors.gradientButtonStart,
                PColors.gradientButtonEnd,
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Center(
                child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: Assets.fontsSVNGilroySemiBold,
                fontSize: 18,
              ),
            )),
          ),
        ),
      );
    }
  }
}
