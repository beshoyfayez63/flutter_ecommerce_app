import 'package:amazone_clone/common/widgets/carousal_images.dart';
import 'package:amazone_clone/common/widgets/search_appbar.dart';
import 'package:amazone_clone/features/home/widgets/deel_of_day.dart';
import 'package:amazone_clone/features/home/widgets/top_categories.dart';
import 'package:flutter/material.dart';

import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/home/widgets/address_box.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            CarosalImages(images: GlobalVariables.carouselImages),
            SizedBox(height: 15),
            DealOfDay()
          ],
        ),
      ),
    );
  }
}
