import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/features/home/widgets/category_products.dart';
import 'package:amazone_clone/providers/products.provider.dart';
import '../../../constants/global_variables.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const routeName = '/category-deals';
  const CategoryDealsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  String categoryName = '';
  Future? _getCategoryProducts;

  Future _getProductsByCategory(String categoryName) {
    return Provider.of<ProductsProvider>(context, listen: false)
        .getProductsByCategory(categoryName);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryName = (ModalRoute.of(context)?.settings.arguments as String);
    _getCategoryProducts = _getProductsByCategory(categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Text(
          categoryName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep Shopping for $categoryName',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 170,
            child: FutureBuilder(
              future: _getCategoryProducts,
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
                  return const CategoryProducts();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
