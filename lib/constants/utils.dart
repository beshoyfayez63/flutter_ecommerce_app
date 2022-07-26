import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
  );
}

transformImages(String imageUrl, int imgWidth, int imgHeight) {
  return CloudinaryImage(imageUrl)
      .transform()
      .width(imgWidth)
      .height(imgHeight);
}
