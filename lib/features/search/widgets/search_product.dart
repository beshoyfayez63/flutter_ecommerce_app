import 'package:amazone_clone/common/widgets/average_rating.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  final bool iscartProduct;
  const SearchedProduct({
    required this.product,
    this.iscartProduct = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 135,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                transformImages(product.images[0], 135, 135).toString(),
                // fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(fontSize: 16),
                maxLines: 2,
              ),
              const SizedBox(height: 5),
              if (!iscartProduct) AverageRating(product: product),
              const SizedBox(height: 5),
              const Text(
                'Eligible for free shipping',
                maxLines: 2,
              ),
              const SizedBox(height: 5),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 5),
              const Text(
                'In Stock',
                style: TextStyle(color: Colors.teal),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
