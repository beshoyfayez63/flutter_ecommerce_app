import 'package:amazone_clone/common/widgets/badge.dart';
import 'package:amazone_clone/features/account/screens/account_screen.dart';
import 'package:amazone_clone/features/cart/screens/cart_screen.dart';
import 'package:amazone_clone/features/home/screens/home.dart';
import 'package:amazone_clone/providers/user.dart';
import 'package:flutter/material.dart';

import 'package:amazone_clone/constants/global_variables.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _selectedTabIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void _changePageIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 28,
        onTap: _changePageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 5,
                    color: _selectedTabIndex == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.transparentColor,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 5,
                    color: _selectedTabIndex == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.transparentColor,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 5,
                    color: _selectedTabIndex == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.transparentColor,
                  ),
                ),
              ),
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.isCartEmpty) {
                    return const Icon(Icons.shopping_cart_outlined);
                  }
                  return Badge(
                    count: '${userProvider.getCartItems.length}',
                    color: Colors.red,
                    child: const Icon(Icons.shopping_cart_outlined),
                  );
                },
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
