import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:amazone_clone/constants/dio.dart';
import 'package:amazone_clone/models/order.dart';

class OrderProvider with ChangeNotifier {
  String? token;
  List<Order> _userOrders = [];

  OrderProvider(this.token, this._userOrders);

  List<Order> get userOrders {
    return _userOrders;
  }

  Future<void> getUserOrder() async {
    try {
      final response = await Api().dio.get('/api/orders/me');
      final extractedOrders = _extractedOrders(response.data);
      _userOrders = extractedOrders;
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  List<Order> _extractedOrders(List<dynamic> response) {
    return response.map((order) => Order.fromJson(json.encode(order))).toList();
  }
}
