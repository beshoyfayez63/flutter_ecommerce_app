import 'dart:convert';

import 'package:amazone_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  factory Product.init() {
    return Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
      id: '',
      rating: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: double.parse(map['quantity'].toString()),
      images: (map['images'] as List<dynamic>).isNotEmpty
          ? (map['images'] as List<dynamic>).map((image) => '$image').toList()
          : [],
      category: map['category'] ?? '',
      price: double.parse(map['price'].toString()),
      rating: map['ratings'] != null
          ? (map['ratings'] as List<dynamic>)
              .map(
                (rat) => Rating(userId: rat['userId'], rating: rat['rating']),
              )
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? quantity,
    List<String>? images,
    String? category,
    double? price,
    String? userId,
    List<Rating>? rating,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }

  factory Product.fromJson(String source) => Product.fromMap(
        json.decode(source),
      );
}
