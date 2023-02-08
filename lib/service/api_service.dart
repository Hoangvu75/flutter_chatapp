import 'dart:io';

import 'package:chatapp/models/add-chat/add_chat_body.dart';
import 'package:chatapp/models/get-chat/get_chat_body.dart';
import 'package:chatapp/models/get-chat/get_chat_response.dart';
import 'package:chatapp/models/get-chatbox-list/get_chatbox_list_body.dart';
import 'package:chatapp/models/get-chatbox-list/get_chatbox_list_response.dart';
import 'package:chatapp/models/login/login_body.dart';
import 'package:chatapp/models/otp/generate_otp_response.dart';
import 'package:chatapp/models/profile/add_profile_response.dart';
import 'package:chatapp/models/register/register_body.dart';
import 'package:chatapp/models/register/register_response.dart';
import 'package:chatapp/models/search-phone/search_phone_body.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../generated/assets.dart';
import '../models/add-chat/add_chat_response.dart';
import '../models/create-chatbox/create_chatbox_body.dart';
import '../models/create-chatbox/create_chatbox_response.dart';
import '../models/login/login_response.dart';
import '../models/profile/add_profile_body.dart';
import '../models/profile/get_profile_response.dart';
import '../models/search-phone/search_phone_response.dart';
import '../utils/app_functions.dart';
import '../utils/app_utils.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static final CustomDialog _customDialog = CustomDialog();

  static ApiService create() {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.connectTimeout = 60000;
    dio.interceptors.add(PrettyDioLogger());
    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    return ApiService(
      dio,
      baseUrl: baseUrl,
    );
  }

  static ApiService createWithAuthorization(String authorization) {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.connectTimeout = 60000;
    dio.options.headers["Authorization"] = authorization;
    dio.interceptors.add(PrettyDioLogger());
    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    return ApiService(
      dio,
      baseUrl: baseUrl,
    );
  }

  static ApiService createWithErrorHandler(
      Function cancelCallback, Function confirmCallback, String errorContent) {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.connectTimeout = 60000;
    dio.interceptors.add(PrettyDioLogger());

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError dioError, ErrorInterceptorHandler handler) => {
          if (dioError.response != null && dioError.response?.statusCode != 200)
            {
              _customDialog.showDialog(
                SvgPicture.asset(Assets.svgsIcSystemError),
                "${dioError.response!.statusCode.toString()} ${dioError.response!.statusMessage.toString()}",
                errorContent,
                cancelCallback,
                confirmCallback,
              ),
            },
        },
      ),
    );

    return ApiService(
      dio,
      baseUrl: baseUrl,
    );
  }

  @POST("/authen/login")
  Future<LoginResponse> postLogin(@Body() LoginBody loginBody);

  @POST("/authen/register")
  Future<RegisterResponse> postRegister(@Body() RegisterBody registerBody);

  @POST("/account/add-profile")
  Future<AddProfileResponse> postAddProfile(@Body() AddProfileBody addProfileBody);

  @GET("/account/get-profile")
  Future<GetProfileResponse> getProfile();

  @POST("/authen/generate-otp")
  Future<GenerateOtpResponse> getGenerateOTP();

  @POST("/search-phone")
  Future<SearchPhoneResponse> searchPhone(@Body() SearchPhoneBody searchPhoneBody);

  @POST("/create-chatbox")
  Future<CreateChatboxResponse> createChatbox(@Body() CreateChatboxBody createChatboxBody);

  @POST("/get-chatbox-list")
  Future<GetChatboxListResponse> getChatboxList(@Body() GetChatboxListBody getChatboxListBody);

  @POST("/get-chat")
  Future<GetChatResponse> getChat(@Body() GetChatBody getChatBody);

  @POST("/add-chat")
  Future<AddChatResponse> addChat(@Body() AddChatBody addChatBody);
}

// flutter pub run build_runner build--delete-conflicting-outputs