import 'package:chatapp/models/add-chat/add_chat_body.dart';
import 'package:chatapp/models/get-chat/get_chat_body.dart';
import 'package:chatapp/models/get-chat/get_chat_response.dart';
import 'package:chatapp/screens/chatScreen/components/fake_chat_item.dart';
import 'package:chatapp/service/api_service.dart';
import 'package:chatapp/utils/app_utils.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel with ChangeNotifier {
  late List<Chat> chatList = [];
  late List<FakeChatItem> fakeChatList = [];

  Future<void> onGetChatResponse(GCBUser user1, GCBUser user2) async {
    final getChatResponse = await ApiService.create().getChat(GetChatBody(user1: user1, user2: user2));
    chatList = getChatResponse.chatbox!.chat!;
    notifyListeners();
  }

  Future<void> onAddChat(ACBUser user1, ACBUser user2, String content) async {
    await ApiService.create().addChat(
      AddChatBody(
        user1: user1,
        user2: user2,
        sender: phoneNumber,
        content: content,
        time: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }

  Future<void> onAddFakeChat(String content, int type) async {
    fakeChatList.add(FakeChatItem(
      chat: content,
      type: type,
    ));
    notifyListeners();
  }

  void onDispose() {
    chatList = [];
    fakeChatList = [];
  }
}
