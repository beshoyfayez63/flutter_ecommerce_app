import 'dart:convert';

import 'package:amazone_clone/common/widgets/average_rating.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/providers/products.provider.dart';
import 'package:amazone_clone/providers/user.dart';
import 'package:flutter/material.dart';

import 'package:amazone_clone/common/widgets/carousal_images.dart';
import 'package:amazone_clone/common/widgets/rating.dart';
import 'package:amazone_clone/common/widgets/search_appbar.dart';
import 'package:amazone_clone/common/widgets/signup_button.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-details';
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _loading = false;

  Future<void> _ratProduct(
    int rating,
    Product product,
  ) async {
    try {
      await Provider.of<ProductsProvider>(context, listen: false)
          .ratingProduct(product, rating);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addToCart(Product product) async {
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .addToCart(product);
    } catch (e) {
      showSnackBar(context, 'Something went wrong, please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = (ModalRoute.of(context)?.settings.arguments as Product);
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    print(product.rating);

    return Scaffold(
      appBar: const SearchAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.id!),
                  AverageRating(product: product),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            CarosalImages(
              images: product.images,
              height: 250,
            ),
            Container(height: 5, color: Colors.black12),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      )
                    ]),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.description,
              ),
            ),
            const SizedBox(height: 10),
            Container(height: 5, color: Colors.black12),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomButton(btnText: 'Buy Now', onTap: () {}),
                  const SizedBox(height: 10),
                  CustomButton(
                    btnText: 'Add to Cart',
                    onTap: () => _addToCart(product),
                    color: const Color.fromRGBO(254, 216, 19, 1),
                  ),
                ],
              ),
            ),
            Container(height: 5, color: Colors.black12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Rate the product',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Rating(
                    currentRating: product.rating!.isNotEmpty
                        ? product.rating!
                            .firstWhere((rat) => rat.userId == userId)
                            .rating
                        : 0,
                    onRatingSelected: (rating) => _ratProduct(
                      rating,
                      product,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
