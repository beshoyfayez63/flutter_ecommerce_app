import 'package:flutter/material.dart';

class CarosalImages extends StatelessWidget {
  final List<String> images;
  final double height;
  const CarosalImages({required this.images, this.height = 200, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> carousalItems = images
        .map(
          (image) => SizedBox(
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        )
        .toList();

    return Column(
      children: [
        SizedBox(
          height: height,
          child: Stack(
            children: [
              PageView(
                children: carousalItems,
              )
            ],
          ),
        )
      ],
    );
  }
}
