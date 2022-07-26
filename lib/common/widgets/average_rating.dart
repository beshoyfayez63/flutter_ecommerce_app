import 'package:amazone_clone/models/product.dart';
import 'package:flutter/material.dart';

import 'package:amazone_clone/common/widgets/rating.dart';

class AverageRating extends StatefulWidget {
  final Product product;
  const AverageRating({required this.product, Key? key}) : super(key: key);

  @override
  State<AverageRating> createState() => _AverageRatingState();
}

class _AverageRatingState extends State<AverageRating> {
  int averageRating = 0;
  int totalRating = 0;
  @override
  void initState() {
    super.initState();
    if (widget.product.rating == null || widget.product.rating!.isEmpty) return;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
    }

    averageRating = (totalRating / widget.product.rating!.length).truncate();
  }

  @override
  Widget build(BuildContext context) {
    return Rating(
      currentRating: averageRating,
    );
  }
}
