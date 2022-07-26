import 'package:flutter/material.dart';

class CartSubtotal extends StatelessWidget {
  final double sumTotal;
  const CartSubtotal({required this.sumTotal, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Subtotal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '\$$sumTotal',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
