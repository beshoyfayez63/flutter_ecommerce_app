import 'dart:ui';

import 'package:amazone_clone/features/account/widgets/account_button.dart';
import 'package:amazone_clone/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(
              text: 'Your Orders',
              onPress: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onPress: () {},
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(
              text: 'Logout',
              onPress: () =>
                  Provider.of<UserProvider>(context, listen: false).logout(),
            ),
            AccountButton(
              text: 'Your wish list',
              onPress: () {},
            ),
          ],
        ),
      ],
    );
  }
}
