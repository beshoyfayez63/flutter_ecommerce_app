// import 'dart:convert';

// // import 'package:amazone_clone/providers/user.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// // import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:amazone_clone/constants/error_handler.dart';
// import 'package:amazone_clone/models/user.dart';
// import 'package:amazone_clone/constants/global_variables.dart';
// import 'package:amazone_clone/constants/utils.dart';

// class AuthService {
//   Future<void> singupUser({
//     required String email,
//     required String password,
//     required String name,
//     required BuildContext context,
//   }) async {
//     final url = Uri.parse('$uri/api/signup');
//     try {
//       User user = User(
//         id: '',
//         email: email,
//         name: name,
//         password: password,
//         address: '',
//         type: '',
//         token: '',
//       );

//       final response = await http.post(
//         url,
//         body: user.toJson(),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       httpStatusHandler(
//           response: response,
//           context: context,
//           onSuccess: () {
//             showSnackBar(context, 'Account has been created');
//           });
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> singinUser({
//     required String email,
//     required String password,
//   }) async {
//     final url = Uri.parse('$uri/api/signin');
//     try {
//       final response = await http.post(
//         url,
//         body: json.encode({'email': email, 'password': password}),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       httpStatusHandler(
//           response: response,
//           onSuccess: () async {
//             final prefs = await SharedPreferences.getInstance();
//             await prefs.setString(
//               'token',
//               json.decode(response.body)['token'],
//             );
//           });
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
