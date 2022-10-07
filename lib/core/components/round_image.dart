import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:true_tips_mobile/core/constants/system.dart';

class RoundedImage extends StatelessWidget {
  double? width;
  double? height;
  ImageProvider? image;

  RoundedImage({this.width, this.height, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      height: height ?? 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
        image: DecorationImage(
          image: image ?? AssetImage(System.imgPlaceholder),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
