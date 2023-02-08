import 'package:flutter/cupertino.dart';

class ScrollControllerProvider with ChangeNotifier {
  ScrollController? bodyScrollController;

  void createScrollControlListener() {
    bodyScrollController = ScrollController();
    bodyScrollController!.addListener(scrollControllerChanged);
  }

  void scrollControllerChanged() {

  }

  void jumpToMaxPosition() {
    bodyScrollController!.jumpTo(bodyScrollController!.position.maxScrollExtent);
  }

  void onDispose() {
    bodyScrollController!.dispose();
    bodyScrollController!.removeListener(scrollControllerChanged);
  }
}