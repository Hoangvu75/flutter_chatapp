import 'package:chatapp/models/create-chatbox/create_chatbox_body.dart';
import 'package:chatapp/models/search-phone/search_phone_body.dart';
import 'package:chatapp/models/search-phone/search_phone_response.dart';
import 'package:flutter/material.dart';

import '../../service/api_service.dart';
import '../../utils/app_utils.dart';

class SearchScreenViewModel with ChangeNotifier {
  bool loading = false;

  SearchPhoneResponse? searchPhoneResponse;

  Future<void> search(String phone) async {
    loading = true;
    notifyListeners();

    searchPhoneResponse = await ApiService.create().searchPhone(
      SearchPhoneBody(phone: phone),
    );
    loading = false;
    notifyListeners();
  }

  Future<void> connect(String connectPhone) async {
    loading = true;
    notifyListeners();

    var getProfileResponse = await ApiService.createWithAuthorization(accessToken).getProfile();
    await ApiService.create().createChatbox(
      CreateChatboxBody(
        user1: CCBUser(
          accountId: getProfileResponse.profile!.accountId!,
          phone: getProfileResponse.profile!.phone!,
          name: getProfileResponse.profile!.name!,
          birthday: getProfileResponse.profile!.birthday!,
          avatar: getProfileResponse.profile!.avatar!,
        ),
        user2: CCBUser(
          accountId: searchPhoneResponse!.profile!.accountId!,
          phone: searchPhoneResponse!.profile!.phone!,
          name: searchPhoneResponse!.profile!.name!,
          birthday: searchPhoneResponse!.profile!.birthday!,
          avatar: searchPhoneResponse!.profile!.avatar!,
        ),
      ),
    );

    loading = false;
    notifyListeners();
  }
}
