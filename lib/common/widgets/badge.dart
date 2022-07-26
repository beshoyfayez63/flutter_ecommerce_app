import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String count;
  final Color color;
  const Badge({
    required this.child,
    required this.count,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: 0,
          right: -2,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),

            // constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Text(
              count,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
