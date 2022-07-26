import 'dart:convert';
import 'dart:io';

import 'package:amazone_clone/constants/dio.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:amazone_clone/models/sales.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:amazone_clone/models/product.dart';

class AdminProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Order> _allOrders = [];

  final String? token;
  AdminProvider(this.token, this._products, this._allOrders);

  List<Product> get products {
    return _products;
  }

  List<Order> get allOrders {
    return _allOrders;
  }

  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      if (token == null || token!.isEmpty) return;
      final cloudinary = CloudinaryPublic('dxmy1rwdx', 'tsxm3nuy');
      List<String> imagesUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imagesUrls.add(response.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imagesUrls,
      );

      await Api().dio.post(
            '/admin/add-product',
            data: product.toJson(),
          );
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> getAllProducts() async {
    try {
      final response = await Api().dio.get('/admin/get-products');
      final extractedProducts = _extractedProducts(response.data);
      _products = extractedProducts;
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await Api().dio.post(
            '/admin/delete-product',
            data: json.encode({'id': id}),
          );
      _products.removeWhere((product) => product.id == id);
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> getAllOrders() async {
    try {
      final response = await Api().dio.get('/admin/get-orders');
      final extractedOrders = _extractedOrders(response.data);
      _allOrders = extractedOrders;
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> changeOrderStatus(int status, Order order) async {
    try {
      final response = await Api().dio.post(
            '/admin/change-order-status',
            data: json.encode({'id': order.id, 'status': status}),
          );
      final extractedOrder = Order.fromMap(response.data);
      final orderIndex = _allOrders.indexWhere(
        (order) => extractedOrder.id == order.id,
      );
      _allOrders[orderIndex] = extractedOrder;
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<Map<String, dynamic>> getAnalytics() async {
    try {
      List<Sales> sales = [];
      int totalEarnings = 0;
      final response = await Api().dio.get('/admin/analytics');
      final responseData = (response.data as Map<String, dynamic>);

      totalEarnings = responseData['totalEarnings'];
      sales = [
        Sales('Mobiles', responseData['mobileEarnings']),
        Sales('Essentials', responseData['essentialEarnings']),
        Sales('Books', responseData['applianceEarnings']),
        Sales('Appliances', responseData['booksEarnings']),
        Sales('Fashion', responseData['fashionEarnings']),
      ];
      return {'sales': sales, 'totalEarnings': totalEarnings};
    } on DioError catch (e) {
      throw e.message;
    }
  }

  List<Order> _extractedOrders(List<dynamic> responseData) {
    return responseData.map((order) => Order.fromMap(order)).toList();
  }

  List<Product> _extractedProducts(List<dynamic> responseData) {
    return responseData.map((p) => Product.fromMap(p)).toList();
  }
}
