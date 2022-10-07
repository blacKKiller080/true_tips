import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  Color? color;

  CircularProgressBar({this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(color ?? Colors.white),
    );
  }
}
