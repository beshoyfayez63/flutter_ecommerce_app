import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amazone_clone/constants/global_variables.dart';

class Api {
  final dio = createDio();

  Api._internal();

  static final _singelton = Api._internal();

  factory Api() => _singelton;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(baseUrl: uri),
    );
    dio.interceptors.addAll({AppInterceptors(dio)});
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    super.onRequest(options, handler);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    String? token;
    if (userData != null) {
      token = json.decode(userData)['token'];
    } else {
      token = null;
    }

    options.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token,
    });
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    switch (err.type) {
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            print('ERROR ${err.response?.data['msg']}');
            throw err.response?.data['msg'];
          case 500:
            print(err.response?.data['error']);
            throw 'Something went wrong';
          default:
            return;
        }
      case DioErrorType.connectTimeout:
        break;
      case DioErrorType.sendTimeout:
        break;
      case DioErrorType.receiveTimeout:
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        break;
    }
    return handler.next(err);
  }
}
