import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/search/widgets/search_product.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
  final Product product;
  final int quantity;
  const CartProduct({
    required this.product,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  Future<void> _addToCart(BuildContext context) async {
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .addToCart(product);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _removeFromCart(BuildContext context) async {
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .removeFromCart(product);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchedProduct(
          product: product,
          iscartProduct: true,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => _removeFromCart(context),
                      child: Container(
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(
                        '$quantity',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () => _addToCart(context),
                      child: Container(
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
