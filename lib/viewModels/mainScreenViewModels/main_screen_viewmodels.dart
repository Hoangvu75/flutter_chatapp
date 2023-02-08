import 'package:chatapp/models/get-chatbox-list/get_chatbox_list_body.dart';
import 'package:chatapp/models/get-chatbox-list/get_chatbox_list_response.dart';
import 'package:chatapp/service/api_service.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';

class MainScreenViewModel with ChangeNotifier {

  List<ChatboxList> chatboxList = [];
  Future<void> getChatBoxList() async {
    var getChatboxListResponse = await ApiService.create().getChatboxList(
      GetChatboxListBody(
        phone: phoneNumber,
      ),
    );
    chatboxList = getChatboxListResponse.chatboxList!;
    notifyListeners();
  }

  void onDispose() {
    chatboxList = [];
    notifyListeners();
  }
}
