import 'package:amazone_clone/features/address/screens/address_screen.dart';
import 'package:amazone_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazone_clone/features/admin/screens/admin_screen.dart';
import 'package:amazone_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazone_clone/features/order_details/screens/order_details.dart';
import 'package:amazone_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazone_clone/features/search/screens/search_screen.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/providers/admin_provider.dart';
import 'package:amazone_clone/providers/order.provider.dart';
import 'package:amazone_clone/providers/products.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amazone_clone/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/common/screens/loading_screen.dart';
import 'package:amazone_clone/common/widgets/bottom_bar.dart';
import 'package:amazone_clone/providers/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProxyProvider<UserProvider, AdminProvider>(
          create: (ctx) => AdminProvider(null, [], []),
          update: (ctx, auth, previousAdmin) => AdminProvider(
              auth.token, previousAdmin!.products, previousAdmin.allOrders),
        ),
        ChangeNotifierProxyProvider<UserProvider, ProductsProvider>(
          create: (ctx) => ProductsProvider(null, [], [], [], Product.init()),
          update: (ctx, auth, previousProducts) => ProductsProvider(
            auth.token,
            previousProducts!.products,
            previousProducts.categoryProducts,
            previousProducts.searchProducts,
            previousProducts.productDealOfDay,
          ),
        ),
        ChangeNotifierProxyProvider<UserProvider, OrderProvider>(
          create: (ctx) => OrderProvider(null, []),
          update: (ctx, user, order) =>
              OrderProvider(user.token, order!.userOrders),
        )
      ],
      child: Consumer<UserProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amazone Clone',
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? auth.isAdmin
                  ? const AdminScreen()
                  : const BottomBar()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      return const AuthScreen();
                    }
                  },
                ),
          routes: {
            AddProductScreen.routeName: (ctx) => const AddProductScreen(),
            CategoryDealsScreen.routeName: (ctx) => const CategoryDealsScreen(),
            SearchScreen.routeName: (ctx) => const SearchScreen(),
            ProductDetailsScreen.routeName: (ctx) =>
                const ProductDetailsScreen(),
            AddressScreen.routeName: (ctx) => const AddressScreen(),
            OrderDetailsScreen.routerName: (ctx) => const OrderDetailsScreen(),
          },
        ),
      ),
    );
  }
}
