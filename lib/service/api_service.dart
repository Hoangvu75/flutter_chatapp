import 'dart:io';

import 'package:chatapp/models/login/login_body.dart';
import 'package:chatapp/models/profile/add_profile_response.dart';
import 'package:chatapp/models/register/register_body.dart';
import 'package:chatapp/models/register/register_response.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../generated/assets.dart';
import '../models/login/login_response.dart';
import '../models/profile/add_profile_body.dart';
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
}
