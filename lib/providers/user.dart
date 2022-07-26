import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amazone_clone/models/user.dart';
import 'package:amazone_clone/models/cart.dart';
import 'package:amazone_clone/models/product.dart';

import 'package:amazone_clone/constants/dio.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    password: '',
    address: '',
    name: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  String get userAddress => _user.address;

  bool get isAdmin => _user.type == 'admin';

  String get token => _user.token;

  bool get isAuth {
    return token.isNotEmpty;
  }

  bool get isCartEmpty => _user.cart.isEmpty;

  List<Cart> get getCartItems => _user.cart;

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.decode(prefs.getString('userData') ?? '');
    if (userData == null || (userData['token'] as String).isEmpty) {
      prefs.setString('userData', '');
      return false;
    }
    try {
      final response = await Api().dio.post('/api/tokenIsValid');
      if (!response.data) {
        await prefs.setString('userData', '');
        return false;
      }
      final userResponse = await Api().dio.get('/');
      _user = User.fromMap(userResponse.data);
      notifyListeners();
      await prefs.setString('userData', _user.toJson());
      return true;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> singupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final createdUser = _user.copyWith(
        email: email,
        password: password,
        name: name,
      );
      await Api().dio.post(
            '/api/signup',
            data: json.encode(
              createdUser.toMap(),
            ),
          );
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> singinUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await Api().dio.post('/api/signin',
          data: json.encode({
            'email': email,
            'password': password,
          }));

      _user = User.fromMap(response.data);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'userData',
        json.encode(response.data),
      );
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> addToCart(Product product) async {
    try {
      final response = await Api().dio.post(
            '/api/add-to-cart',
            data: json.encode({'id': product.id}),
          );
      _user = _user.copyWith(
        cart: List<Cart>.from(
          (response.data['cart'] as List<dynamic>).map((c) => Cart.fromMap(c)),
        ),
      );
      notifyListeners();
      _addToStorage('userData', _user.toJson());
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> removeFromCart(Product product) async {
    try {
      final response =
          await Api().dio.delete('/api/remove-from-cart/${product.id}');
      _user = _user.copyWith(
        cart: List<Cart>.from(
          (response.data['cart'] as List<dynamic>).map((c) => Cart.fromMap(c)),
        ),
      );
      notifyListeners();
      _addToStorage('userData', _user.toJson());
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> saveUserAddress(String address) async {
    try {
      final response = await Api().dio.post(
            '/api/save-user-address',
            data: json.encode({'address': address}),
          );
      _user = _user.copyWith(address: response.data['address']);
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> createOrder(double totalPrice) async {
    try {
      await Api().dio.post(
            '/api/order',
            data: json.encode({
              'cart': _user.cart,
              'address': _user.address,
              'totalPrice': totalPrice,
            }),
          );
      _user = _user.copyWith(cart: []);
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> logout() async {
    _user = User(
      id: '',
      email: '',
      name: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: [],
    );
    notifyListeners();
    await _addToStorage('userData', _user.toJson());
  }

  Future<void> _addToStorage(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
