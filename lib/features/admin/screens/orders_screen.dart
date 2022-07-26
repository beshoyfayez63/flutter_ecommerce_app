import 'package:amazone_clone/common/widgets/loading.dart';
import 'package:amazone_clone/features/account/widgets/product.dart';
import 'package:amazone_clone/features/order_details/screens/order_details.dart';
import 'package:amazone_clone/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
        future:
            Provider.of<AdminProvider>(context, listen: false).getAllOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return Consumer<AdminProvider>(
              builder: (ctx, adminProvider, value) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, index) {
                    final order = adminProvider.allOrders[index];
                    return InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                        OrderDetailsScreen.routerName,
                        arguments: order,
                      ),
                      child: Product(
                        image: order.products[0].images[0],
                        // imgWidth: 160,
                        // imgHeight: 140,
                      ),
                    );
                  },
                  itemCount: adminProvider.allOrders.length,
                );
              },
            );
          }
        },
      ),
    );
  }
}
