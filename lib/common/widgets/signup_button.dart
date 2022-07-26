import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    this.color,
    required this.btnText,
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        btnText,
        style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
