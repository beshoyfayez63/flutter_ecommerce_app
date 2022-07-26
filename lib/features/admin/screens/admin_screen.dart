import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/admin/screens/analytics_screen.dart';
import 'package:amazone_clone/features/admin/screens/orders_screen.dart';
import 'package:amazone_clone/features/admin/screens/products_screen.dart';
import 'package:amazone_clone/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var _selectedTabIndex = 0;

  List<Widget> pages = [
    const ProductsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/amazon_in.png',
              width: 120,
              height: 45,
              color: Colors.black,
            ),
            const Text(
              'Admin',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Provider.of<UserProvider>(context, listen: false).logout(),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: pages[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        onTap: (tabIndex) {
          setState(() {
            _selectedTabIndex = tabIndex;
          });
        },
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
              child: const Icon(Icons.home),
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
              child: const Icon(Icons.analytics_outlined),
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
              child: const Icon(Icons.all_inbox_outlined),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
