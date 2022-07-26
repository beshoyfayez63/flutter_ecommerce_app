import 'package:amazone_clone/common/widgets/loading.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/widgets/product.dart';
import 'package:amazone_clone/features/order_details/screens/order_details.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:amazone_clone/providers/order.provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  void _navigateToOrderDetails(BuildContext context, Order order) {
    Navigator.of(context)
        .pushNamed(OrderDetailsScreen.routerName, arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OrderProvider>(context, listen: false).getUserOrder(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<OrderProvider>(
                builder: (context, orderProvider, child) {
                  final orderProducts = orderProvider.userOrders;
                  return Container(
                    height: 180,
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 15,
                      right: 0,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        final productImage =
                            orderProducts[index].products[0].images[0];
                        return Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () => _navigateToOrderDetails(
                                  context, orderProducts[index]),
                              child: Product(image: productImage),
                            ),
                            const SizedBox(width: 10)
                          ],
                        );
                      },
                      itemCount: orderProducts.length,
                    ),
                  );
                },
              )
            ],
          );
        }
      },
    );
  }
}
