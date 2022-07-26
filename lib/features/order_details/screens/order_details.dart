import 'package:amazone_clone/common/widgets/search_appbar.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/order_details/widgets/track_order.dart';
import 'package:flutter/material.dart';

import 'package:amazone_clone/models/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const routerName = '/order-details';
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)?.settings.arguments as Order;
    final orderDate =
        DateTime.fromMicrosecondsSinceEpoch(order.orderedAt * 1000);
    final formatedDate =
        '${orderDate.day}-${orderDate.month}-${orderDate.year}';
    // final dateParse = DateTime.parse('$orderDate');

    return Scaffold(
      appBar: const SearchAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date: $formatedDate'),
                    const SizedBox(height: 10),
                    Text('Order ID: ${order.id}'),
                    const SizedBox(height: 10),
                    Text('Order Total: \$${order.totalPrice}'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Purchase details:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < order.products.length; i++)
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              transformImages(
                                      order.products[i].images[0], 120, 120)
                                  .toString(),
                              height: 120,
                              width: 120,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.products[i].name,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text('total quantity ${order.quantity[i]}'),
                              ],
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TrackOrder(order: order),
            ],
          ),
        ),
      ),
    );
  }
}
