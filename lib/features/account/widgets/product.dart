import 'package:amazone_clone/constants/utils.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String image;
  final int imgWidth;
  final int imgHeight;
  const Product({
    Key? key,
    required this.image,
    this.imgWidth = 200,
    this.imgHeight = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.parse('$imgWidth'),
      height: double.parse('$imgHeight'),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1.5),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          '${transformImages(image, imgWidth, imgHeight)}',
          // fit: BoxFit.fitHeight,
          width: double.parse('$imgWidth'),
          height: double.parse('$imgHeight'),
        ),
      ),
    );
  }
}
