class CreateChatboxResponse {
  bool? success;
  String? message;
  Chatbox? chatbox;

  CreateChatboxResponse({this.success, this.message, this.chatbox});

  CreateChatboxResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    chatbox =
    json['chatbox'] != null ? Chatbox.fromJson(json['chatbox']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (chatbox != null) {
      data['chatbox'] = chatbox!.toJson();
    }
    return data;
  }
}

class Chatbox {
  List<CCRUser>? user;
  List<Chat>? chat;
  String? sId;

  Chatbox({this.user, this.chat, this.sId});

  Chatbox.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <CCRUser>[];
      json['user'].forEach((v) {
        user!.add(CCRUser.fromJson(v));
      });
    }
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(Chat.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    return data;
  }
}

class CCRUser {
  String? accountId;
  String? phone;
  String? name;
  String? birthday;
  String? avatar;
  String? sId;

  CCRUser(
      {this.accountId,
        this.phone,
        this.name,
        this.birthday,
        this.avatar,
        this.sId});

  CCRUser.fromJson(Map<String, dynamic> json) {
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
