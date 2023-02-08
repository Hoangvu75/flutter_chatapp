class GetChatboxListResponse {
  bool? success;
  List<ChatboxList>? chatboxList;

  GetChatboxListResponse({this.success, this.chatboxList});

  GetChatboxListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['chatboxList'] != null) {
      chatboxList = <ChatboxList>[];
      json['chatboxList'].forEach((v) {
        chatboxList!.add(ChatboxList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (chatboxList != null) {
      data['chatboxList'] = chatboxList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatboxList {
  String? sId;
  List<GCLRUser>? user;
  List<Chat>? chat;
  int? iV;

  ChatboxList({this.sId, this.user, this.chat, this.iV});

  ChatboxList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['user'] != null) {
      user = <GCLRUser>[];
      json['user'].forEach((v) {
        user!.add(GCLRUser.fromJson(v));
      });
    }
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(Chat.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class GCLRUser {
  String? accountId;
  String? phone;
  String? name;
  String? birthday;
  String? avatar;
  String? sId;

  GCLRUser(
      {this.accountId,
        this.phone,
        this.name,
        this.birthday,
        this.avatar,
        this.sId});

  GCLRUser.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    phone = json['phone'];
    name = json['name'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['phone'] = phone;
    data['name'] = name;
    data['birthday'] = birthday;
    data['avatar'] = avatar;
    data['_id'] = sId;
    return data;
  }
}

class Chat {
  String? sender;
  String? content;
  String? time;
  String? sId;

  Chat({this.sender, this.content, this.time, this.sId});

  Chat.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    content = json['content'];
    time = json['time'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender'] = sender;
    data['content'] = content;
    data['time'] = time;
    data['_id'] = sId;
    return data;
  }
}
