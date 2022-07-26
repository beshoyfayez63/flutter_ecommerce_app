import 'package:flutter/material.dart';

import 'package:amazone_clone/constants/global_variables.dart';

class Rating extends StatefulWidget {
  final int maximumRating;
  // final double rating;
  int currentRating;
  final Function(int rating)? onRatingSelected;
  Rating({
    this.currentRating = 0,
    this.maximumRating = 5,
    // required this.rating,
    this.onRatingSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _currentRaiting = 0;

  @override
  void initState() {
    super.initState();

    _currentRaiting = widget.currentRating;
  }

  // bool ratingHaveFraction() {
  //   return (widget.rating - widget.rating.truncate()) > 0;
  // }

  Widget _buildRatingStars(int index) {
    if (index < _currentRaiting) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        child: const Icon(
          Icons.star,
          color: GlobalVariables.secondaryColor,
        ),
      );
    }
    return Container(
        margin: const EdgeInsets.only(right: 10),
        child: const Icon(
          Icons.star_outline,
        ));
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(
      widget.maximumRating,
      (index) {
        return GestureDetector(
          onTap: widget.onRatingSelected != null
              ? () {
                  if (_currentRaiting == index + 1) {
                    setState(() {
                      _currentRaiting = 0;
                      widget.currentRating = _currentRaiting;
                    });
                  } else {
                    setState(() {
                      _currentRaiting = index + 1;
                      widget.currentRating = _currentRaiting;
                    });
                  }

                  widget.onRatingSelected!(_currentRaiting);
                }
              : null,
          child: _buildRatingStars(index),
        );
      },
    );

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
