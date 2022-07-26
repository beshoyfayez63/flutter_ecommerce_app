import 'package:amazone_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

final List<Widget> _carousalItems = GlobalVariables.carouselImages
    .map(
      (image) => SizedBox(
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    )
    .toList();

class CarosalImage extends StatelessWidget {
  const CarosalImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              PageView(
                children: _carousalItems,
              )
            ],
          ),
        )
      ],
    );
  }
}
