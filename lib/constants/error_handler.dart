import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:amazone_clone/constants/utils.dart';

void httpStatusHandler({
  required response,
  BuildContext? context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      return onSuccess();
    case 400:
      // print(response.data.msg);
      // throw HttpException(json.decode(response.body)['msg']);
      throw HttpException(response['data']['msg']);
    case 500:
      // return showSnackBar(context, json.decode(response.body)['error']);
      throw HttpException(json.decode(response.body)['error']);
    default:
      return onSuccess();
  }
}

class HttpException implements Exception {
  final String msg;
  HttpException(this.msg);

  @override
  String toString() {
    return msg;
  }
}

// void onError(DioError err, ErrorInterceptorHandler handler) {
//   switch (err.type) {
//     case DioErrorType.response:
//       switch (err.response?.statusCode) {
//         case 400:
//           throw err.message;
//         case 500:
//           throw err.error;
//         default:
//           return;
//       }
//   }
// }
