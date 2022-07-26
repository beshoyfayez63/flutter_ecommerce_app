import 'dart:convert';

import 'package:amazone_clone/models/product.dart';

class Cart {
  final Product product;
  final int quantity;
  Cart({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    print(map['quantity']);
    return Cart(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
