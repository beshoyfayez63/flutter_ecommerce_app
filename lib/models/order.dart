// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazone_clone/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  int status;
  final double totalPrice;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Order copyWith({
    String? id,
    List<Product>? products,
    List<int>? quantity,
    String? address,
    String? userId,
    int? orderedAt,
    int? status,
    double? totalPrice,
  }) {
    return Order(
      id: id ?? this.id,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((p) => p.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: (map['products'] as List<dynamic>).isNotEmpty
          ? List<Product>.from(
              (map['products'] as List<dynamic>).map(
                (p) => Product.fromMap(p['product']),
              ),
            )
          : [],
      quantity: (map['products'] as List<dynamic>).isNotEmpty
          ? List<int>.from(
              (map['products'] as List<dynamic>).map((p) => p['quantity']),
            )
          : [],
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt'] ?? 0,
      status: map['status'] ?? 0,
      totalPrice: (map['totalPrice'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
