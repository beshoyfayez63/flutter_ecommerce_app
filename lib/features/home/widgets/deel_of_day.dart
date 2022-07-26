import 'package:amazone_clone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/common/widgets/loading.dart';
import 'package:amazone_clone/providers/products.provider.dart';
import 'package:amazone_clone/constants/utils.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<ProductsProvider>(context, listen: false).getDealOfDay(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return Consumer<ProductsProvider>(
            builder: (context, productProvider, child) {
              var product = productProvider.productDealOfDay;
              if (product.images.isEmpty) {
                return Container();
              }

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ProductDetailsScreen.routeName,
                      arguments: product);
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      product.images[0],
                      height: 235,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: Text('${product.price}'),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, right: 40),
                      child: Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: product.images
                              .map(
                                (image) => ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    transformImages(image, 100, 100).toString(),
                                    fit: BoxFit.fitWidth,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    child!,
                  ],
                ),
              );
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'See all deals',
                style: TextStyle(
                  color: Colors.cyan[800],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
