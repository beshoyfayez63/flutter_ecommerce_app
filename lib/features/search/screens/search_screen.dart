import 'package:amazone_clone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/common/widgets/loading.dart';
import 'package:amazone_clone/common/widgets/search_appbar.dart';
import 'package:amazone_clone/features/home/widgets/address_box.dart';
import 'package:amazone_clone/features/search/widgets/search_product.dart';
import 'package:amazone_clone/providers/products.provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = '';
  Future? _getSearchProducts;

  Future _searchProductsByName() {
    search = (ModalRoute.of(context)?.settings.arguments as String);
    return Provider.of<ProductsProvider>(context, listen: false)
        .searchProductsByName(search);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getSearchProducts = _searchProductsByName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(),
      body: FutureBuilder(
        future: _getSearchProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return Consumer<ProductsProvider>(builder: (ctx, products, child) {
              return Column(
                children: [
                  const AddressBox(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.searchProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ProductDetailsScreen.routeName,
                              arguments: products.searchProducts[index],
                            );
                          },
                          child: SearchedProduct(
                            product: products.searchProducts[index],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            });
          }
        },
      ),
    );
  }
}
