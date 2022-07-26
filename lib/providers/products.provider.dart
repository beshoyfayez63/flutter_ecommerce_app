import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/constants/dio.dart';

class ProductsProvider with ChangeNotifier {
  String? token;
  List<Product> _products = [];
  List<Product> _categoryProducts = [];
  List<Product> _searchProducts = [];
  Product _productDealOfDay;

  ProductsProvider(
    this.token,
    this._products,
    this._categoryProducts,
    this._searchProducts,
    this._productDealOfDay,
  );

  List<Product> get products {
    return _products;
  }

  List<Product> get categoryProducts {
    return _categoryProducts;
  }

  List<Product> get searchProducts {
    return _searchProducts;
  }

  Product get productDealOfDay {
    return _productDealOfDay;
  }

  Future<void> getProductsByCategory(String categoryName) async {
    try {
      final response =
          await Api().dio.get('/api/products?category=$categoryName');
      final List<Product> extractedCategoryProducts =
          _extractProducts(response.data);
      _categoryProducts = extractedCategoryProducts;
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> searchProductsByName(String productName) async {
    try {
      final response = await Api().dio.get('/api/products/search/$productName');

      final List<Product> extractedSearchProducts =
          _extractProducts(response.data);
      _searchProducts = extractedSearchProducts;
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> ratingProduct(Product product, int rating) async {
    try {
      await Api().dio.post(
            '/api/rate-product',
            data: json.encode({
              'id': product.id,
              'rating': rating.toString(),
            }),
          );
    } on DioError catch (e) {
      throw e.error;
    }
  }

  Future<void> getDealOfDay() async {
    try {
      final response = await Api().dio.get('/api/deal-of-day');
      _productDealOfDay = Product.fromMap(response.data);
      notifyListeners();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  List<Product> _extractProducts(List<dynamic> response) {
    return response.map((product) => Product.fromMap(product)).toList();
  }
}
