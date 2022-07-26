import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/providers/products.provider.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProducts =
        Provider.of<ProductsProvider>(context).categoryProducts;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.4,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final product = categoryProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailsScreen.routeName, arguments: product);
          },
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    transformImages(product.images[0], 120, 120).toString(),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 5, top: 7, right: 15),
                child: Text(
                  product.name,
                  maxLines: 1,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        );
      },
      itemCount: categoryProducts.length,
    );
  }
}
