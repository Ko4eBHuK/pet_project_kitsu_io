import 'package:flutter/material.dart';

Image showNetworkImage(String? link) {
  Image result;

  try {
    if (link != null)
      result = Image.network(
        link,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset('images/no_photo.png');
        },
      );
    else
      result = Image.asset('images/no_photo.png');
  } catch (e) {
    result = Image.asset('images/no_photo.png');
  }

  return result;
}
