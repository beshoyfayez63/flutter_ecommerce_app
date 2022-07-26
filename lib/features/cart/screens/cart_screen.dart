import 'package:amazone_clone/common/widgets/search_appbar.dart';
import 'package:amazone_clone/common/widgets/signup_button.dart';
import 'package:amazone_clone/features/address/screens/address_screen.dart';
import 'package:amazone_clone/features/cart/widgets/cart_product.dart';
import 'package:amazone_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazone_clone/features/home/widgets/address_box.dart';
import 'package:amazone_clone/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void _navigateToAddress(BuildContext context, double sum) {
    Navigator.of(context)
        .pushNamed(AddressScreen.routeName, arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    final sum = user.cart.fold<double>(
      0,
      (previousValue, cartItem) =>
          previousValue += cartItem.quantity * cartItem.product.price,
    );

    return Scaffold(
      appBar: const SearchAppBar(),
      body: Column(
        children: [
          const AddressBox(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CartSubtotal(sumTotal: sum),
                const SizedBox(height: 10),
                CustomButton(
                  btnText: 'Proceed to Buy (${user.cart.length})',
                  color: Colors.yellow[600],
                  onTap: () => _navigateToAddress(context, sum),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: user.cart.length,
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  product: user.cart[index].product,
                  quantity: user.cart[index].quantity,
                );
                // return Text('Hello');
              },
            ),
          ),
        ],
      ),
    );
  }
}
