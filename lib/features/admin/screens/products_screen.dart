import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/features/account/widgets/product.dart';
import 'package:amazone_clone/features/admin/screens/add_product_screen.dart';

import 'package:amazone_clone/providers/admin_provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future? _fetchProducts;

  Future _getProducts() {
    return Provider.of<AdminProvider>(context, listen: false).getAllProducts();
  }

  Future<void> _onRefresh() async {
    await _getProducts();
  }

  Future<void> _deleteProduct(String id) async {
    Provider.of<AdminProvider>(
      context,
      listen: false,
    ).deleteProduct(id);
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts = _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<AdminProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 140,
                          child: Product(
                            image: productsData.products[index].images[0],
                            imgWidth: 170,
                            imgHeight: 140,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                productsData.products[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () => _deleteProduct(
                                    productsData.products[index].id!),
                                icon: const Icon(Icons.delete),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                  itemCount: productsData.products.length,
                ),
              ),
            );
          }
        },
        future: _fetchProducts,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddProductScreen.routeName);
        },
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
